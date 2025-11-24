from models import Loan
from database import get_db
from datetime import date, datetime
import os

def Registrera_nytt_lån(db, book_id, member_id, due_date_str):
    due_date = datetime.strptime(due_date_str, "%Y-%m-%d").date()
    nytt_lån = Loan(book_id=book_id, member_id=member_id, due_date=due_date, return_date=None)
    db.add(nytt_lån)
    db.commit()
    db.refresh(nytt_lån)
    return nytt_lån

def Registrera_återlämning(db, loan_id):
    lån = db.query(Loan).filter(Loan.id == loan_id).first()
    if lån and lån.return_date is None:
        lån.return_date = date.today()
        db.commit()
        db.refresh(lån)
        return lån
    return None

def Visa_aktiva_lån(db):
    return db.query(Loan).filter(Loan.return_date == None).all()

def Visa_försenade_lån(db, current_date_str):
    current_date = datetime.strptime(current_date_str, "%Y-%m-%d").date()
    return db.query(Loan).filter(Loan.due_date < current_date, Loan.return_date == None).all()

def loan_meny():
    db = next(get_db())
    while True:
        print("\nLånmeny:")
        print("1. Registrera nytt lån")
        print("2. Registrera återlämning")
        print("3. Visa aktiva lån")
        print("4. Visa försenade lån")
        print("5. Återgå till huvudmenyn")

        val = input("Välj ett alternativ: ")

        if val == '1':
            os.system('cls')
            book_id = int(input("Ange bok-ID: "))
            member_id = int(input("Ange medlem-ID: "))
            due_date = input("Ange förfallodatum (YYYY-MM-DD): ")
            lån = Registrera_nytt_lån(db, book_id, member_id, due_date)
            print(f"Nytt lån registrerat med ID {lån.id}.")
        elif val == '2':
            os.system('cls')
            loan_id = int(input("Ange låne-ID för återlämning: "))
            lån = Registrera_återlämning(db, loan_id)
            if lån:
                print(f"Lån med ID {lån.id} har registrerats som återlämnat.")
            else:
                print("Ogiltigt låne-ID eller lånet är redan återlämnat.")
        elif val == '3':
            os.system('cls')
            lån_lista = Visa_aktiva_lån(db)
            if not lån_lista:
                print("Inga aktiva lån just nu.")
            for lån in lån_lista:
                print(f"Lån ID: {lån.id}, Bok ID: {lån.book_id}, Medlem ID: {lån.member_id}, Förfallodatum: {lån.due_date}")
        elif val == '4':
            os.system('cls')
            current_date = input("Ange dagens datum (YYYY-MM-DD): ")
            lån_lista = Visa_försenade_lån(db, current_date)
            if not lån_lista:
                print("Inga försenade lån just nu.")
            for lån in lån_lista:
                print(f"Lån ID: {lån.id}, Bok ID: {lån.book_id}, Medlem ID: {lån.member_id}, Förfallodatum: {lån.due_date}")
        elif val == '5':
            os.system('cls')
            break
        else:
            print("Ogiltigt val, försök igen.")
