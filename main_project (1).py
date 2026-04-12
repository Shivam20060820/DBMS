import mysql.connector

# 🔌 CONNECTION
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="#Gamerforlife123",
    database="dbms_project1"
)

cursor = conn.cursor()
print("✅ Connected to database successfully!")

while True:
    print("\n========== CRIMINAL DBMS ==========")
    print("1. Show Tables")
    print("2. View All Criminals")
    print("3. Search Criminal by ID")
    print("4. View Case Overview (VIEW)")
    print("5. Find Criminal by FIR ID")
    print("6. Add Full Case (Smart Insert)")
    print("7. Exit")

    choice = int(input("Enter your choice: "))

    # 🔹 1. SHOW TABLES
    if choice == 1:
        cursor.execute("SHOW TABLES")
        for table in cursor.fetchall():
            print(table[0])

    # 🔹 2. VIEW CRIMINALS
    elif choice == 2:
        cursor.execute("SELECT * FROM criminal")
        for row in cursor.fetchall():
            print(row)

    # 🔹 3. SEARCH CRIMINAL
    elif choice == 3:
        cid = int(input("Enter Criminal ID: "))

        cursor.execute("SELECT * FROM criminal WHERE cri_id = %s", (cid,))
        result = cursor.fetchone()

        if result:
            print("\n🔍 Found:", result)
        else:
            print("❌ Not found!")

    # 🔹 4. VIEW (CASEOVERVIEW)
    elif choice == 4:
        cursor.execute("SELECT * FROM caseoverview")
        for row in cursor.fetchall():
            print(row)

    # 🔹 5. FIND CRIMINAL BY FIR ID
    elif choice == 5:
        fir_id = int(input("Enter FIR ID: "))

        query = """
        SELECT c.* 
        FROM criminal c
        JOIN fir f ON c.cri_id = f.cri_id
        WHERE f.fir_id = %s
        """

        cursor.execute(query, (fir_id,))
        result = cursor.fetchall()

        if result:
            for row in result:
                print(row)
        else:
            print("❌ No record found!")

    # 🔹 6. SMART INSERT (MAIN PART 🔥)
    elif choice == 6:
        print("\n🚨 Enter Full Case Details")

        # 🔹 POLICE STATION
        ps_choice = input("Use existing Police Station? (y/n): ")

        if ps_choice.lower() == 'y':
            ps_id = int(input("Enter existing PS ID: "))

            cursor.execute("SELECT * FROM police_station WHERE ps_id = %s", (ps_id,))
            if not cursor.fetchone():
                print("❌ Invalid PS ID!")
                continue

        else:
            ps_id = int(input("New Police Station ID: "))
            ps_name = input("Name: ")
            district = input("District: ")
            state = input("State: ")
            contact = input("Contact: ")

            cursor.execute("SELECT * FROM police_station WHERE contactno = %s", (contact,))
            if cursor.fetchone():
                print("⚠️ Police Station already exists!")
                continue

            cursor.execute(
                "INSERT INTO police_station VALUES (%s, %s, %s, %s, %s)",
                (ps_id, ps_name, district, state, contact)
            )

        # 🔹 CRIMINAL
        cr_choice = input("Use existing Criminal? (y/n): ")

        if cr_choice.lower() == 'y':
            cid = int(input("Enter existing Criminal ID: "))

            cursor.execute("SELECT * FROM criminal WHERE cri_id = %s", (cid,))
            if not cursor.fetchone():
                print("❌ Invalid Criminal ID!")
                continue

        else:
            cid = int(input("New Criminal ID: "))
            name = input("Name: ")
            gender = input("Gender: ")
            dob = input("DOB (YYYY-MM-DD): ")
            status = input("Status: ")
            mark = input("Identification Mark: ")
            address = input("Address: ")

            cursor.execute(
                "INSERT INTO criminal VALUES (%s, %s, %s, %s, %s, %s, %s)",
                (cid, name, gender, dob, status, mark, address)
            )

        # 🔹 FIR
        fir_id = int(input("FIR ID: "))
        fir_no = input("FIR No: ")
        fir_date = input("FIR Date: ")
        crime_type = input("Crime Type: ")
        desc = input("Description: ")

        cursor.execute("SELECT * FROM fir WHERE fir_id = %s", (fir_id,))
        if cursor.fetchone():
            print("❌ FIR ID already exists!")
            continue

        cursor.execute(
            "INSERT INTO fir VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (fir_id, fir_no, fir_date, ps_id, cid, crime_type, desc)
        )

        # 🔹 CASE DETAILS (FIXED 🔥)
        case_id = int(input("Case ID: "))
        case_status = input("Case Status: ")
        filing_date = input("Filing Date: ")

        cursor.execute(
            "INSERT INTO case_details (case_id, fir_id, case_status, filing_date) VALUES (%s, %s, %s, %s)",
            (case_id, fir_id, case_status, filing_date)
        )

        conn.commit()
        print("✅ Full Case Added Successfully!")

    # 🔹 EXIT
    elif choice == 7:
        print("👋 Exiting...")
        break

    else:
        print("❌ Invalid choice!")

# 🔒 CLOSE
cursor.close()
conn.close()