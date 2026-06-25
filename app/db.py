import psycopg2

def get_connection():
    return psycopg2.connect(
        host="127.0.0.1",
        database="food_delivery",
        user="postgres",
        password="Abdsep03",
        port="5432"
    )