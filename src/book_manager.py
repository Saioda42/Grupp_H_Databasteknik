from models import Book
from database import get_db
import os

def lägg_till_bok(db, title, author):
    ny_bok = Book(title=title, author=author, is_available=True)
    db.add(ny_bok)
    db.commit()
    db.refresh(ny_bok)
    return ny_bok

def sök_efter_bok(db, title):
    return db.query(Book).filter(Book.title.ilike(f"%{title}%")).all()

def visa_alla_bocker(db):
    return db.query(Book).all()

def tillgangliga_bocker(db):
    return db.query(Book).filter(Book.available_copies > 0).all()

def bok_meny():
    db = next(get_db())
    while True:
        print("\nBokhanteringsmeny:")
        print("1. Lägg till bok")
        print("2. Sök efter bok")
        print("3. Visa alla böcker")
        print("4. Visa tillgängliga böcker")
        print("5. Återgå till huvudmenyn")

        val = input("Välj ett alternativ: ")

        if val == '1':
            os.system('cls')
            title = input("Ange boktitel: ")
            author = input("Ange författare: ")
            bok = lägg_till_bok(db, title, author)
            print(f"Bok '{bok.title}' av {bok.author} har lagts till.")
        elif val == '2':
            os.system('cls')
            title = input("Ange boktitel att söka efter: ")
            böcker = sök_efter_bok(db, title)
            if böcker:
                for bok in böcker:
                    status = "Tillgänglig" if bok.available_copies else "Utlånad"
                    print(f"{bok.id}: {bok.title} av {bok.author} - {status}")
            else:
                print("Inga böcker hittades med den titeln.")
        elif val == '3':
            os.system('cls')
            böcker = visa_alla_bocker(db)
            for bok in böcker:
                status = "Tillgänglig" if bok.available_copies else "Utlånad"
                print(f"{bok.id}: {bok.title} av {bok.author} - {status}")
        elif val == '4':
            os.system('cls')
            böcker = tillgangliga_bocker(db)
            for bok in böcker:
                print(f"{bok.id}: {bok.title} av {bok.author} - Tillgänglig")
        elif val == '5':
            os.system('cls')
            break
        else:
            print("Ogiltigt val, försök igen.")