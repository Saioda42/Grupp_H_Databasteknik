from models import Member
from database import get_db
from utils import clear_screen
from sqlalchemy import or_
import os


def Visa_alla_medlemmar(db):
    return db.query(Member).all()

def lägg_till_medlem(db, first_name, last_name, email):
    ny_medlem = Member(first_name=first_name, last_name=last_name, email=email)
    db.add(ny_medlem)
    db.commit()
    db.refresh(ny_medlem)
    return ny_medlem

def sök_efter_medlem(db, query):
    query = query.strip()
    return (
        db.query(Member)
        .filter(
            or_(
            Member.first_name.ilike(f"%{query}%"), 
            Member.last_name.ilike(f"%{query}%"),
            Member.email.ilike(f"%{query}%")
            )
        )
        .all()
    )

def member_meny():
    db = next(get_db())
    try:
        while True:
            print("\nMedlemshanteringsmeny:")
            print("1. Lägg till medlem")
            print("2. Sök efter medlem")
            print("3. Visa alla medlemmar")
            print("4. Återgå till huvudmenyn")

            val = input("Välj ett alternativ: ")

            if val == '1':
                clear_screen()
                first_name = input("Ange förnamn: ")
                last_name = input("Ange efternamn: ")
                email = input("Ange medlems-e-post: ")
                medlem = lägg_till_medlem(db, first_name, last_name, email)
                print(f"Medlem '{medlem.first_name} {medlem.last_name}' har lagts till.")
            elif val == '2':
                clear_screen()
                namn = input("Ange namn att söka efter: ")
                medlemmar = sök_efter_medlem(db, namn)
                if medlemmar:
                    for medlem in medlemmar:
                        print(f"{medlem.id}: {medlem.first_name} {medlem.last_name} - {medlem.email}")
                else:
                    print("Inga medlemmar hittades med det namnet.")
            elif val == '3':
                clear_screen()
                medlemmar = Visa_alla_medlemmar(db)
                if not medlemmar:
                    print("Inga medlemmar registrerade.")
                for medlem in medlemmar:
                    print(f"{medlem.id}: {medlem.first_name} {medlem.last_name} - {medlem.email}")
            elif val == '4':
                clear_screen()
                break
            else:
                print("Ogiltigt val, försök igen.")
    finally:
            db.close()