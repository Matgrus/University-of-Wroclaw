
use piston::input::GenericEvent;

use crate::Gameboard;

//use std::process;

pub struct GameboardController {
    pub gameboard: Gameboard,
    pub selected_cell: Option<[usize; 2]>,
    cursor_pos: [f64; 2],
    pub win: bool
}

impl GameboardController {
    pub fn new(gameboard: Gameboard) -> GameboardController {
        GameboardController {
            gameboard: gameboard,
            selected_cell: None,
            cursor_pos: [0.0; 2],
            win: false
        }
    }

    pub fn event<E: GenericEvent>(&mut self, size: f64, e: &E) {
        use piston::input::{Button, MouseButton};
        
        // cursor position

        if let Some(pos) = e.mouse_cursor_args() {
            self.cursor_pos = pos;
        }

        // left mouse button click

        if let Some(Button::Mouse(MouseButton::Left)) = e.press_args() {
            if self.cursor_pos[0] >= 0.0 && self.cursor_pos[0] < size && self.cursor_pos[1] >= 0.0 && self.cursor_pos[1] < size {
                let cell_x = (self.cursor_pos[0] / size * 9.0) as usize;
                let cell_y = (self.cursor_pos[1] / size * 9.0) as usize;
                self.selected_cell = Some([cell_x, cell_y]);
            }
        }

        // key press

        if let Some(Button::Keyboard(key)) = e.press_args() {
            if let Some(ind) = self.selected_cell {
                match key {
                    piston::Key::Left => {
                        if self.selected_cell.unwrap()[0] > 0 {
                            self.selected_cell = Some([self.selected_cell.unwrap()[0] - 1, self.selected_cell.unwrap()[1]])
                        }
                    },
                    piston::Key::Right => {
                        if self.selected_cell.unwrap()[0] < 8 {
                            self.selected_cell = Some([self.selected_cell.unwrap()[0] + 1, self.selected_cell.unwrap()[1]])
                        }
                    },
                    piston::Key::Up => {
                        if self.selected_cell.unwrap()[1] > 0 {
                            self.selected_cell = Some([self.selected_cell.unwrap()[0], self.selected_cell.unwrap()[1] - 1])
                        }
                    },
                    piston::Key::Down => {
                        if self.selected_cell.unwrap()[1] < 8 {
                            self.selected_cell = Some([self.selected_cell.unwrap()[0], self.selected_cell.unwrap()[1] + 1])
                        }
                    },
                    piston::Key::D1 => self.gameboard.set(ind, 1),
                    piston::Key::D2 => self.gameboard.set(ind, 2),
                    piston::Key::D3 => self.gameboard.set(ind, 3),
                    piston::Key::D4 => self.gameboard.set(ind, 4),
                    piston::Key::D5 => self.gameboard.set(ind, 5),
                    piston::Key::D6 => self.gameboard.set(ind, 6),
                    piston::Key::D7 => self.gameboard.set(ind, 7),
                    piston::Key::D8 => self.gameboard.set(ind, 8),
                    piston::Key::D9 => self.gameboard.set(ind, 9),
                    piston::Key::Backspace => self.gameboard.set(ind, 0),
                    _ => {}
                };

                if self.gameboard.check_game(){
                    //process::exit(123);
                    self.win = true;
                }
            }
        }
    }
}