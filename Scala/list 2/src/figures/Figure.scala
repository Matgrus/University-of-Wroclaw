package figures

abstract class Figure{
  def area : Double
  def description : String
}

class Triangle(a: Point, b: Point, c: Point) extends Figure{
  def area: Double = {
    0.5 * math.abs((b.x.to_double() - a.x.to_double()) * (c.y.to_double() - a.y.to_double()) - (b.y.to_double() - a.y.to_double()) * (c.x.to_double() - a.x.to_double()))
  }

  def description: String ={
    "Triangle"
  }
}

class Rectangle(a: Point, b: Point, c: Point, d: Point) extends Figure{
  def area: Double = {
    val ab: Double = math.sqrt(math.pow(a.x.to_double() - b.x.to_double(), 2) + math.pow(b.y.to_double() - a.y.to_double(), 2))
    val ac: Double = math.sqrt(math.pow(a.x.to_double() - c.x.to_double(), 2) + math.pow(c.y.to_double() - a.y.to_double(), 2))
    val ad: Double = math.sqrt(math.pow(a.x.to_double() - d.x.to_double(), 2) + math.pow(d.y.to_double() - a.y.to_double(), 2))
    if(ab > ac && ab > ad) ac * ad else if(ac > ab && ac > ad) ab * ad else ac * ab
  }

  def description: String ={
    "Rectangle"
  }
}

/*
class Rectangle(a: Point, b: Point, c: Point) extends Figure{
  def area: Double = {
    val ab: Double = math.sqrt(math.pow(a.x.to_double() - b.x.to_double(), 2) + math.pow(b.y.to_double() - a.y.to_double(), 2))
    val ac: Double = math.sqrt(math.pow(a.x.to_double() - c.x.to_double(), 2) + math.pow(c.y.to_double() - a.y.to_double(), 2))
    val bc: Double = math.sqrt(math.pow(b.x.to_double() - c.x.to_double(), 2) + math.pow(c.y.to_double() - b.y.to_double(), 2))
    if(ab > ac && ab > bc) ac * bc else if(ac > ab && ac > bc) ab * bc else ac * ab
  }

  def description: String ={
    "Rectangle"
  }
}*/

class Square(a: Point, b: Point) extends Figure{
  def area: Double = {
    math.pow(math.abs(a.x.to_double() - b.x.to_double()), 2)
  }

  def description: String ={
    "Square"
  }
}

object singleton{
  def areaSum(figures: List[Figure]): Double = {
    //(for (x <- figures) yield x.area).sum
    figures.map(_.area).sum
  }
  def printAll(figures: List[Figure]): Unit = {
    for (x <- figures) println(x.description)
  }
}
