from sqlalchemy import func
from models import Book, Loan, Member 
from database import get_db
from utils import clear_screen


def visa_biblioteksoversikt(db):
    antal_bocker = db.query(func.count(Book.id)).scalar()
    antal_medlemmar = db.query(func.count(Member.id)).scalar()
    aktiva_lan = (
            db.query(func.count(Loan.id))
            .filter(Loan.return_date == None)
            .scalar()
    )
    
    print("\n--- Biblioteksöversikt ---")
    print(f"Totalt antal böcker: {antal_bocker}")
    print(f"Totalt antal medlemmar: {antal_medlemmar}")
    print(f"Aktiva lån: {aktiva_lan}")


def visa_mest_lanade_bocker(db, limit=5):
    resultat = (
        db.query(
            Book.title, func.count(Loan.id).label("antal_lan")
        )
        .join(Loan, Loan.book_id == Book.id)
        .group_by(Book.id, Book.title)
        .order_by(func.count(Loan.id).desc())
        .limit(limit)
        .all()
    )

    print("\n--- Mest lånade böcker ---")
    if not resultat:
        print("Inga lån hittades.")
        return
    
    for titel, antal in resultat:
        print(f"{titel} - {antal} lån")


def visa_medlem_med_flest_lan(db):
    resultat = (
        db.query(
            Member.first_name,
            Member.last_name,
            func.count(Loan.id).label("antal_lan")
        )
        .join(Loan, Loan.member_id == Member.id)
        .group_by(Member.id, Member.first_name, Member.last_name)
        .order_by(func.count(Loan.id).desc())
        .limit(1)
        .all()
    )

    print("\n--- Medlem med flest lån ---")
    if not resultat:
        print("Inga lån hittades.")
        return

    for fnamn, enamn, antal in resultat:
        print(f"{fnamn} {enamn} - {antal} lån")

 
def statistik_meny():
    db = next(get_db())
    try:
        while True:
            print("\nStatistikmeny:")
            print("1. Visa översikt av biblioteket")
            print("2. Visa mest lånade böcker")
            print("3. Visa medlem med flest lån")
            print("4. Återgå till huvudmenyn")

            val = input("Välj ett alternativ: ")

            if val == '1':
                clear_screen()
                visa_biblioteksoversikt(db)
            elif val == '2':
                clear_screen()
                visa_mest_lanade_bocker(db)
            elif val == '3':
                clear_screen()
                visa_medlem_med_flest_lan(db)
            elif val == '4':
                clear_screen()
                break
            else:
                print("Ogiltigt val, försök igen.")
    finally:
        db.close()