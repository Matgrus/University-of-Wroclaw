from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship

import sys


engine = create_engine("sqlite:///database.db", echo=True)
session = sessionmaker(bind=engine)()
Base = declarative_base()


class Book(Base):
    __tablename__ = "books"

    id = Column(Integer, primary_key=True)
    author = Column(String, nullable=False)
    title = Column(String, nullable=False)
    year = Column(Integer, nullable=False)
    owner = relationship("Lending", uselist=False, back_populates="book")

    def __init__(self, id, author, title, year):
        self.id = id
        self.author = author
        self.title = title
        self.year = year

    def __str__(self):
        return "Book = id: " + str(self.id) + ", author: " + self.author + ", title: " + self.title + ", year: " + str(self.year)


class Person(Base):
    __tablename__ = "friends"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    mail = Column(String, nullable=False)
    books = relationship("Lending")

    def __init__(self, id, name, mail):
        self.id = id
        self.name = name
        self.mail = mail

    def __str__(self):
        return "Person = id: " + str(self.id) + ", name: " + self.name + ", mail: " + self.mail


class Lending(Base):
    __tablename__ = "lendings"

    id = Column(Integer, primary_key=True)
    book_id = Column(Integer, ForeignKey("books.id"), nullable=False)
    person_id = Column(Integer, ForeignKey("friends.id"), nullable=False)
    book = relationship("Book", back_populates="owner")

    def __init__(self, id, book, person):
        self.id = id
        self.book_id = book
        self.person_id = person

    def __str__(self):
        book = session.query(Book).filter(Book.id == self.book_id).all()[0].title
        person = session.query(Person).filter(Person.id == self.person_id).all()[0].name
        return "Lending = id: " + str(self.id) + ", book title: " + book + ", person: " + person


Base.metadata.create_all(engine)


i = 1
while i < len(sys.argv):
    if sys.argv[i] == "--addperson":
        session.add(Person(sys.argv[i + 1], sys.argv[i + 2], sys.argv[i + 3]))
        i += 4
    elif sys.argv[i] == "--addbook":
        session.add(Book(sys.argv[i + 1], sys.argv[i + 2], sys.argv[i + 3], sys.argv[i + 4]))
        i += 5
    elif sys.argv[i] == "--addlending":
        book = session.query(Book).filter(Book.id == sys.argv[i + 2]).all()[0].id
        person = session.query(Person).filter(Person.id == sys.argv[i + 3]).all()[0].id
        session.add(Lending(sys.argv[i + 1], book, person))
        i += 4
    elif sys.argv[i] == "--delperson":
        x = session.query(Person).filter(Person.id == sys.argv[i + 1]).all()[0]
        session.delete(x)
        i += 2
    elif sys.argv[i] == "--delbook":
        x = session.query(Book).filter(Book.id == sys.argv[i + 1]).all()[0]
        session.delete(x)
        i += 2
    elif sys.argv[i] == "--dellending":
        x = session.query(Lending).filter(Lending.id == sys.argv[i + 1]).all()[0]
        session.delete(x)
        i += 2
    elif sys.argv[i] == "--showallbooks":
        lista = session.query(Book).all()
        for x in lista:
            print(x)
        i += 1
    elif sys.argv[i] == "--showallpersons":
        lista = session.query(Person).all()
        for x in lista:
            print(x)
        i += 1
    elif sys.argv[i] == "--showalllendings":
        lista = session.query(Lending).all()
        for x in lista:
            print(x)
        i += 1
    else:
        i += 1


session.commit()
session.close()
