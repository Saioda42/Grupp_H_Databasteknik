from book_manager import bok_meny
from loan_manager import loan_meny
from member_manager import member_meny
from statistics_manager import statistik_meny
from utils import clear_screen
import os


def huvudmeny():
    while True:
        print("" + "="*50)
        print("    LIBRARY MANAGEMENT SYSTEM")
        print("="*50)
        print("\nHuvudmeny:")
        print("1. Bokhantering")
        print("2. Medlemshantering")
        print("3. Lånshantering")
        print("4. Statistik")
        print("0. Avsluta")

        val = input("Välj ett alternativ: ")

        if val == '1':
            clear_screen()
            bok_meny()
        elif val == '2':
            clear_screen()
            member_meny()
        elif val == '3':
            clear_screen()
            loan_meny()
        elif val == '4':
            clear_screen()
            statistik_meny()
        elif val == '0':
            clear_screen()
            print("Avslutar programmet.")
            break
        else:
            print("Ogiltigt val, försök igen.")
            
huvudmeny()