from book_manager import bok_meny
from loan_manager import loan_meny
from member_manager import member_meny
import os


def huvudmeny():
    while True:
        print("\nHuvudmeny:")
        print("1. Bokhantering")
        print("2. Medlemshantering")
        print("3. Lånshantering")
        print("4. Avsluta")

        val = input("Välj ett alternativ: ")

        if val == '1':
            os.system('cls')
            bok_meny()
        elif val == '2':
            os.system('cls')
            member_meny()
        elif val == '3':
            os.system('cls')
            loan_meny()
        elif val == '4':
            os.system('cls')
            print("Avslutar programmet.")
            break
        else:
            print("Ogiltigt val, försök igen.")
            
huvudmeny()