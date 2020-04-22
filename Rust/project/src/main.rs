
extern crate piston;
extern crate glutin_window;
extern crate graphics;
extern crate opengl_graphics; 

use piston::window::WindowSettings;
use glutin_window::GlutinWindow;
use piston::event_loop::{Events, EventSettings, EventLoop};
use opengl_graphics::{OpenGL, GlGraphics, Filter, TextureSettings, GlyphCache};
use piston::input::RenderEvent;

use rand::seq::SliceRandom;

pub use crate::gameboard::Gameboard;
mod gameboard;

pub use crate::gameboard_controller::GameboardController;
mod gameboard_controller;

pub use crate::gameboard_view::{GameboardView, GameboardViewSettings};
mod gameboard_view;

fn main() {
    let opengl = OpenGL::V3_2;
    let settings = WindowSettings::new("Sudoku", [720; 2]).graphics_api(opengl).exit_on_esc(true);

    let mut window: GlutinWindow = settings.build().expect("Could not create window");
    let mut events = Events::new(EventSettings::new().lazy(true));
    let mut gl = GlGraphics::new(opengl);

    // generate sudoku

    pub fn hor_check(row: &Vec<(u8, bool)>, val: u8) -> bool{
        for i in 0..9 {
            if row[i].0 == val{
                return false;
            }
        }
        true
    }

    pub fn ver_check(tab: &Vec<Vec<(u8, bool)>>, ind: usize, val: u8) -> bool{
        for i in 0..9 {
            if tab[i][ind].0 == val{
                return false;
            }
        }
        true
    }

    pub fn box_check(tab: &Vec<Vec<(u8, bool)>>, ind: [usize; 2], val: u8) -> bool{
        let section_x = ind[0] / 3;
        let section_y = ind[1] / 3;

        for i in (section_x * 3)..(section_x * 3 + 3){
            for j in (section_y * 3)..(section_y * 3 + 3){
                if tab[i][j].0 == val{
                    return false;
                }
            }
        }
        true
    }

    pub fn fill_cells(tab: &mut Vec<Vec<(u8, bool)>>, mut ind_i: usize, mut ind_j: usize) -> bool {
        if ind_j >= 9 && ind_i < 8 { 
            ind_i += 1; 
            ind_j = 0; 
        } 
        if ind_i >= 9 && ind_j >= 9 {
            return true; 
        }
        if ind_i < 3 { 
            if ind_j < 3 { 
                ind_j = 3; 
            }
        } else if ind_i < 6 { 
            if ind_j == 3 {
                ind_j += 3; 
            }
        } else { 
            if ind_j == 6 { 
                ind_i += 1; 
                ind_j = 0; 
                if ind_i >= 9 { 
                    return true; 
                }
            }
        }

        for num in 1..10 { 
            if box_check(tab, [ind_i, ind_j], num) && hor_check(&tab[ind_i], num) && ver_check(tab, ind_j, num) { 
                tab[ind_i][ind_j].0 = num; 
                if fill_cells(tab, ind_i, ind_j + 1) {
                    return true; 
                }
                tab[ind_i][ind_j].0 = 0; 
            } 
        } 
        return false;
    }

    let mut cells_gen: Vec<Vec<(u8, bool)>> = vec![vec![(0, false); 9]; 9];
    let mut ind: usize = 0;
    for _i in 0..3 {
        let mut vals = vec![1, 2, 3, 4, 5, 6, 7, 8, 9];
        for j in 0..9 {
            let a = *vals.choose(&mut rand::thread_rng()).unwrap() as u8;
            cells_gen[(j / 3) + ind][(j % 3) + ind].0 = a;
            vals.remove(vals.iter().position(|&x| x == a).unwrap());
        }
        ind += 3;
    }

    fill_cells(&mut cells_gen, 0, 3);

    let mut positions: Vec<(usize, usize)> = vec![(0, 0); 81];

    let mut ind = 0;
    for i in 0..9 {
        for j in 0..9 {
            positions[ind] = (i, j);
            ind += 1;
        }
    }

    for i in 0..9 {
        println!("{:?}", cells_gen[i]);
    }    

    
    for _i in 0..2 {
        let aa = *positions.choose(&mut rand::thread_rng()).unwrap();
            cells_gen[aa.0][aa.1] = (0, true);
            positions.remove(positions.iter().position(|&x| x == aa).unwrap());
    }

    let cells_color = cells_gen.clone();
    let gameboard = Gameboard::new(cells_gen);
    let mut gameboard_controller = GameboardController::new(gameboard);
    let gameboard_view_settings = GameboardViewSettings::new();
    let gameboard_view = GameboardView::new(gameboard_view_settings, cells_color);
    
    let texture_settings = TextureSettings::new().filter(Filter::Nearest);
    let ref mut glyphs = GlyphCache::new("CollegiateBlackFLF.ttf", (), texture_settings).expect("Could not load font");

    while let Some(e) = events.next(&mut window) {
        gameboard_controller.event(gameboard_view.settings.size, &e);
        
        if let Some(args) = e.render_args() {
            gl.draw(args.viewport(), |c, g| {
                use graphics::{clear};
                clear([1.0; 4], g);
                gameboard_view.draw(&gameboard_controller, glyphs, &c, g);
            });
        }
    }
}
