from flask import Flask, render_template, request, redirect, url_for, jsonify
from db import get_connection

app = Flask(__name__)

@app.route("/")
def dashboard():
    conn = get_connection()
    cur = conn.cursor()

    # Basic Stats
    cur.execute("SELECT COUNT(*) FROM customer")
    customers = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM orders")
    orders = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM restaurant")
    restaurants = cur.fetchone()[0]

    cur.execute("SELECT COALESCE(SUM(amount),0) FROM payments")
    revenue = cur.fetchone()[0]

    # Additional Stats
    cur.execute("SELECT COUNT(*) FROM menu_items")
    menu_items = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM deliveries")
    deliveries = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM delivery_agents")
    agents = cur.fetchone()[0]

    cur.execute("SELECT ROUND(COALESCE(AVG(rating),0),2) FROM reviews")
    avg_rating = cur.fetchone()[0]

    # Most Active Customer
    cur.execute("""
        SELECT c.name, COUNT(o.order_id) AS total_orders
        FROM customer c
        JOIN orders o
        ON c.customer_id = o.customer_id
        GROUP BY c.name
        ORDER BY total_orders DESC
        LIMIT 1
    """)
    top_customer = cur.fetchone()

    # Top Restaurant by Revenue
    cur.execute("""
        SELECT r.restaurant_name,
               COALESCE(SUM(od.subtotal),0) AS revenue
        FROM restaurant r
        JOIN menu_items m
        ON r.restaurant_id = m.restaurant_id
        JOIN order_details od
        ON m.item_id = od.item_id
        GROUP BY r.restaurant_name
        ORDER BY revenue DESC
        LIMIT 1
    """)
    top_restaurant = cur.fetchone()

    # Recent Orders
    cur.execute("""
        SELECT order_id, status
        FROM orders
        ORDER BY order_id DESC
        LIMIT 5
    """)
    recent_orders = cur.fetchall()

    # Latest Reviews
    cur.execute("""
        SELECT rating, comment
        FROM reviews
        ORDER BY review_id DESC
        LIMIT 3
    """)
    latest_reviews = cur.fetchall()

    cur.close()
    conn.close()

    return render_template(
        "index.html",
        customers=customers,
        orders=orders,
        restaurants=restaurants,
        revenue=revenue,
        menu_items=menu_items,
        deliveries=deliveries,
        agents=agents,
        avg_rating=avg_rating,
        top_customer=top_customer,
        top_restaurant=top_restaurant,
        recent_orders=recent_orders,
        latest_reviews=latest_reviews
    )

@app.route("/restaurants")
def restaurants():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT restaurant_name, address, phone
        FROM restaurant
    """)

    restaurants = cur.fetchall()

    cur.close()
    conn.close()

    return render_template(
        "restaurants.html",
        restaurants=restaurants
    )

@app.route("/menu")
def menu():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT r.restaurant_name,
               m.item_name,
               m.price
        FROM restaurant r,
             menu_items m
        WHERE r.restaurant_id = m.restaurant_id
    """)

    menu_items = cur.fetchall()

    cur.close()
    conn.close()

    return render_template(
        "menu.html",
        menu_items=menu_items
    )

