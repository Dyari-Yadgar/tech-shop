import firebase_admin
from firebase_admin import credentials, firestore
import csv

# Initialize Firebase Admin SDK
cred = credentials.Certificate('tech-shop-3c42a-firebase-adminsdk-fbsvc-a0e5e61b1f.json')
firebase_admin.initialize_app(cred)

# Access Firestore
db = firestore.client()

# Function to retrieve PC parts data from Firestore and save to CSV
def get_data_from_firestore_to_csv():
    # Retrieve data from Firestore
    docs = db.collection('items').stream()

    # Open a CSV file to write the data
    with open('C:/Users/Dyari/Desktop/tech_shop_new/assets/pc_parts_data.csv', mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)

        # Write the header row (field names)
        writer.writerow(['ID', 'Name', 'Type', 'Price', 'Spec', 'Brand', 'isEnable', 'Image'])

        # Write the data for each document in Firestore
        for doc in docs:
            data = doc.to_dict()
            # Use .get() to avoid errors if 'isEnable' is missing
            is_enable = data.get('isenable', False)  # Default to False if 'isEnable' is missing
            image_url = data.get('image', '')  # Get the image URL or path (if available)
            
            # Write the row for this document including the image URL/path
            writer.writerow([doc.id, data.get('name'), data.get('type'), data.get('price'),
                             data.get('spec'), data.get('sharika'), is_enable, image_url])

    print('Data has been saved to assets/pc_parts_data.csv')

# Call the function to fetch data and save it to CSV
get_data_from_firestore_to_csv()
