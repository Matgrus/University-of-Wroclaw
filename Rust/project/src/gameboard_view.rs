
use graphics::types::Color;
use graphics::{Context, Graphics};
use graphics::character::CharacterCache;
use crate::graphics::Transformed;

use crate::gameboard_controller::GameboardController;

pub struct GameboardViewSettings {
    pub size: f64,
    pub cell_color: Color, 
    pub border_color: Color,
    pub board_edge_radius: f64,
    pub section_edge_radius: f64,
    pub cell_edge_radius: f64,
    pub selected_cell_color: Color,
    pub const_cell_color: Color,
    pub text_color: Color, 
}

impl GameboardViewSettings {
    pub fn new() -> GameboardViewSettings {
        GameboardViewSettings {
            size: 720.0,
            cell_color: [0.8, 0.8, 1.0, 1.0],
            border_color: [0.0, 0.0, 0.2, 1.0],
            board_edge_radius: 5.0,
            section_edge_radius: 3.0,
            cell_edge_radius: 1.0,
            selected_cell_color: [0.9, 0.9, 1.0, 1.0],
            const_cell_color: [0.7, 0.7, 0.7, 1.0],
            text_color: [0.0, 0.0, 0.0, 1.0],
        }
    }
}

pub struct GameboardView {
    pub settings: GameboardViewSettings,
    pub gameboard: Vec<Vec<(u8, bool)>>,
}

impl GameboardView {
    pub fn new(settings: GameboardViewSettings, gameboard: Vec<Vec<(u8, bool)>>) -> GameboardView{
        GameboardView {
            settings: settings,
            gameboard: gameboard
        }
    }

    pub fn draw<G: Graphics, C>(&self,controller: &GameboardController,glyphs: &mut C,c: &Context,g: &mut G) where C: CharacterCache<Texture = G::Texture>{
        use graphics::{Image, Line, Rectangle};

        let settings = &self.settings;

        let cell_size = settings.size / 9.0;

        // draw cells

        let mut cell_y: f64 = 0.0;
        for i in 0..9 {
            let mut cell_x: f64 = 0.0;
            for j in 0..9 {
                if self.gameboard[i][j].0 == 0{
                    Rectangle::new(settings.cell_color).draw([cell_x, cell_y, cell_size, cell_size], &c.draw_state, c.transform, g);
                }else{
                    Rectangle::new(settings.const_cell_color).draw([cell_x, cell_y, cell_size, cell_size], &c.draw_state, c.transform, g);
                }
                cell_x += cell_size;
            }
            cell_y += cell_size;
        }

        // green cells if win

        if controller.win {
            Rectangle::new([0.0, 0.7, 0.0, 1.0]).draw([0.0, 0.0, cell_size * 9.0, cell_size * 9.0], &c.draw_state, c.transform, g);
        }

        // selected cell

        if let Some(ind) = controller.selected_cell {
            let pos = [ind[0] as f64 * cell_size, ind[1] as f64 * cell_size];
            let cell_rect = [pos[0], pos[1],cell_size, cell_size];
            Rectangle::new(settings.selected_cell_color).draw(cell_rect, &c.draw_state, c.transform, g);
        }

        // text

        let text_image = Image::new_color(settings.text_color);
        for j in 0..9 {
            for i in 0..9 {
                if let Some(ch) = controller.gameboard.char([i, j]) {
                    let pos = [
                        i as f64 * cell_size + if ch == '1' {30.0} else {25.0},
                        j as f64 * cell_size + 60.0
                    ];
                    if let Ok(character) = glyphs.character(34, ch) {
                        let ch_x = pos[0] + character.left();
                        let ch_y = pos[1] - character.top();
                        let text_image = text_image.src_rect([
                            character.atlas_offset[0],
                            character.atlas_offset[1],
                            character.atlas_size[0],
                            character.atlas_size[1],
                        ]);
                        text_image.draw(character.texture, &c.draw_state, c.transform.trans(ch_x, ch_y), g);
                    }
                }
            }
        }

        let cell_edge = Line::new(settings.border_color, settings.cell_edge_radius);
        let section_edge = Line::new(settings.border_color, settings.section_edge_radius);

        // borders
        
        for i in 0..9 {
            let x: f64 = i as f64 / 9.0 * settings.size;
            let y: f64 = i as f64 / 9.0 * settings.size;
            let x2 = settings.size;
            let y2 = settings.size;

            let vline = [x, 0.0, x, y2];
            let hline = [ 0.0, y, x2, y];

            if (i % 3) == 0 {
                section_edge.draw(vline, &c.draw_state, c.transform, g);
                section_edge.draw(hline, &c.draw_state, c.transform, g);
            }else{
                cell_edge.draw(vline, &c.draw_state, c.transform, g);
                cell_edge.draw(hline, &c.draw_state, c.transform, g);
            }
        }

        // main border

        let board_rect = [0.0, 0.0, settings.size, settings.size];  
        Rectangle::new_border(settings.border_color, settings.board_edge_radius).draw(board_rect, &c.draw_state, c.transform, g);

    }

}