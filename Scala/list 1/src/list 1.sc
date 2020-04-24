import scala.math.sqrt

val list1 = List(1, 2, 3, 4)
val list2 = List(5, 6, 7, 8)

def scalarUgly(xs: List[Int], ys: List[Int]) = {
  var res = 0
  var i = 0
  do{
    res += xs(i) * ys(i)
    i += 1
  }
  while(i < xs.length)
  res
}

scalarUgly(list1, list2)

def scalar(xs: List[Int], ys: List[Int]) = {
  (for(i <- 0 until xs.length)
    yield xs(i) * ys(i)).sum
}

scalar(list1, list2)

val list3 = List(2, 5, 1, 3, 4, 8, 6, 9, 5)

def sortUgly(xs: List[Int]): List[Int] = {
  if(xs.length<2){
    xs
  }else {
    val pivot = xs(xs.length / 2)
    var i = 0
    var left: List[Int] = List()
    var right: List[Int] = Nil
    do {
      if(i!=xs.length/2){
        if (xs(i) <= pivot) {
          left = left:+xs(i)
          i += 1
        } else {
          right = right:+xs(i)
          i += 1
        }
      }else{
        i+=1
      }
    }
    while (i < xs.length)
    sortUgly(left) ::: (pivot :: sortUgly(right))
  }
}

sortUgly(list3)

def sort(xs: List[Int]): List[Int] = {
  if(xs.length<2){
    xs
  }else{
    val pivot = xs.head
    val (left, right) = xs.tail.partition(_<=pivot)
    sort(left) ::: (pivot :: sort(right))
  }
}

sort(list3)

def isPrimeUgly(n: Int): Boolean = {
  if(n<2) false
  else if(n == 2) true
  else{
    var i = 2
    do{
      if(n%i==0){
        return false
      }else{
        i+=1
      }
    }
    while(i<=sqrt(n).toInt+1)
    true
  }
}

isPrimeUgly(2207)

def isPrime(n: Int): Boolean = {
  if(n<2){
    false
  }else if(n==2){
    true
  }else{
    (2 to math.sqrt(n).toInt+1) exists (i => n % i == 0)
  }
}

isPrime(2207)

def primePairsUgly(n : Int): List[(Int, Int)] = {
  def aux(x : Int): List[(Int, Int)] = {
    var j = 1
    var res : List[(Int, Int)] = List()
    do{
      if(x-j < n) {
        res = res :+ (j, x - j)
        j += 1
      }else{
        j+=1
      }
    }
    while(j<=x-j)
    res
  }
  var i = 3
  var ind = 0
  var temp: List[Int] = List()
  var res: List[(Int, Int)] = List()
  do{
    if(isPrime(i)){
      temp = temp :+ i
      res = res ::: aux(temp(ind))
      ind+=1
      i+=1
    }else{
      i+=1
    }
  }
  while(i<=2*n-3)
  res
}

primePairsUgly(5)

def primePairs(n : Int): List[(Int, Int)] = {
  val res = for (i <- 1 until n;
                 j <- i+1 until n
                 if isPrime(i+j))
            yield (i, j)
  res.toList
}

primePairs(5)

val filesHere = new java.io.File(".").listFiles

def fileLinesUgly(file: java.io.File): List[String] = {
  var res: List[String] = List()
  var i = io.Source.fromFile(file).getLines.size
  if(i>0){
    var lines = io.Source.fromFile(file).getLines()
    do{
      res = res :+ lines.next
      i-=1
    }
    while(i>0)
    res
  }else{
    List()
  }
}

val ff = new java.io.File("C:\\Users\\Gruha\\Desktop\\test.txt")
val ff2 = new java.io.File("C:\\Users\\Gruha\\Desktop").listFiles

fileLinesUgly(ff)

def fileLines(file: java.io.File): List[String] = {
  (for (line <- io.Source.fromFile(file).getLines()) yield line).toList
  //stream.close()
}

fileLines(ff)

def printNonEmptyUgly(pattern: String): Unit = {
  var i = 0
  do {
    if (ff2(i).getName.matches(pattern) && fileLines(ff2(i)).nonEmpty) {
      println(ff2(i).getName)
      i += 1
    }
  }
  while(i<ff2.length)
}

printNonEmptyUgly(".+\\.scala$")

def printNonEmpty(pattern: String): Unit = {
  for(file <- ff2)
      if (file.getName.matches(pattern) && fileLines(file).nonEmpty) {
        println(file.getName)
      }
}

printNonEmpty(".+\\.scala$")
