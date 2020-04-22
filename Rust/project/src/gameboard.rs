

pub struct Gameboard {
    pub cells: Vec<Vec<(u8, bool)>>
}

impl Gameboard {
    pub fn new(cells: Vec<Vec<(u8, bool)>>) -> Gameboard {
        Gameboard {
            cells: cells,
        }
    }

    // get value

    pub fn char(&self, ind: [usize; 2]) -> Option<char> {
        Some(match self.cells[ind[1]][ind[0]].0 {
            1 => '1',
            2 => '2',
            3 => '3',
            4 => '4',
            5 => '5',
            6 => '6',
            7 => '7',
            8 => '8',
            9 => '9',
            _ => return None,
        })
    }

    // set value

    pub fn set(&mut self, ind: [usize; 2], val: u8) {
        if self.cells[ind[1]][ind[0]].1 {
            self.cells[ind[1]][ind[0]].0 = val;
        }
    }


    pub fn check_horizontally(&mut self, ind: usize) -> bool{
        let help: Vec<u8> = (&self.cells[ind]).into_iter().map(|x| x.0).collect();
        if help.contains(&0){
            return false;
        }else{
            for i in 1..10 {
                if !help.contains(&i){
                    return false;
                }
            }
            true
        }
    }

    pub fn check_vertically(&mut self, ind: usize) -> bool{
        let tab: Vec<u8> = (&self.cells).into_iter().map(|x| x[ind].0).collect();

        if tab.contains(&0){
            return false;
        }else{
            for i in 1..10 {
                if !tab.contains(&i){
                    return false;
                }
            }
            true
        }
    }

    pub fn check_section(&mut self, ind: [usize; 2]) -> bool{
        let section_x = ind[0] / 3;
        let section_y = ind[1] / 3;
        let mut tab: Vec<u8> = Vec::new();

        for i in (section_x * 3)..(section_x * 3 + 3){
            for j in (section_y * 3)..(section_y * 3 + 3){
                tab.push(self.cells[j][i].0);
            }
        }

        if tab.contains(&0){
            return false;
        }else{
            for i in 1..10 {
                if !tab.contains(&i){
                    return false;
                }
            }
            true
        } 
    }

    pub fn check_game(&mut self) -> bool{
        let help: Vec<[usize; 2]> = vec![[1,1], [7,4], [1,4], [1,7], [4,1], [4,4], [4,7], [7,1], [7,7]];
        for i in 0..9{
            if !self.check_horizontally(i) || !self.check_vertically(i) || !self.check_section(help[i]){
                return false;
            }
        }
        true
    }

}