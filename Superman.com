import sys # Exiting ke liye

# --- GLOBAL INVENTORY ---
# Global inventory ko list ke roop mein store karte hain
player_inventory = []

def start_game():
    global player_inventory
    player_inventory = [] # Naya game shuru hone par inventory reset
  
    print("Welcome, Adventurer! Aapki nayi yatra shuru hoti hai.")
    print("Aapka uddeshya (goal) gufa ke khazane (treasure) ko dhundhna hai.")
    
    # Game room shuru karo
    room_one()

# --- ROOM DEFINITIONS ---

def room_one():
    # Pehla kamra: Gufa ka pravesh aur Item pickup
    print("\n--- Entrance Hall (Pravesh Kaksha) ---")
    
    # Item pickup logic
    if "Purani Talwar" not in player_inventory:
        print("Zameen par ek **Purani Talwar** (Old Sword) padi hai.")
        choice = input("Kya aap Talwar uthana chahte hain (y/n)? ").lower()
        if choice == 'y':
            player_inventory.append("Purani Talwar")
            print("Talwar aapki inventory mein add ho gayi.")
    
    print("\nDo raste hain:")
    print("1. Daayein (Right) jaane waala ek sankra (narrow) rasta.")
    print("2. Baayein (Left) jaane waala ek chauda (wide) rasta.")
    
    choice = input("Aap kis raste ko chunenge (1 ya 2)? ")
    
    if choice == '1':
        room_two()
    elif choice == '2':
        room_three()
    else:
        print("Invalid choice. Please enter 1 or 2.")
        room_one()

def room_two():
    # Doosra kamra: Sankra rasta (Danger/Challenge)
    print("\n--- Narrow Path (Sankra Marg) ---")
    print("Rasta bohot sankra hai. Aage ek **gusse waala Goblin** khada hai!")
    
    # Combat logic
    if "Purani Talwar" in player_inventory:
        print("Aap Talwar nikalte hain aur Goblin se ladne ke liye taiyar hain.")
        print("Aap tezi se Talwar ghumate hain aur Goblin ko hara dete hain!")
        print("Rasta ab khul gaya hai.")
        room_final()
    else:
        print("Aapke paas ladne ke liye koi hathiyar nahi hai.")
        print("Goblin aap par hamla karta hai aur aapko hara deta hai! GAME OVER.")
        play_again()

def room_three():
    # Teesra kamra: Chauda rasta (Leads to Puzzle Room)
    print("\n--- Wide Path (Chauda Marg) ---")
    print("Rasta aage jaake ek bade kamre mein khulta hai.")
    print("Aapke saamne do raste hain:")
    print("1. Ek purana, patthar ka darwaza.")
    print("2. Ek chamakta hua, chota surang (tunnel).")

    choice = input("Aap kis raste ko chunenge (1 ya 2)? ")

    if choice == '1':
        room_four() # Puzzle Room
    elif choice == '2':
        room_five() # Naya room: Secret path
    else:
        print("Invalid choice. Please enter 1 or 2.")
        room_three()

def room_four():
    # Paheli (Riddle) Room
    print("\n--- The Riddle Chamber (Paheli
