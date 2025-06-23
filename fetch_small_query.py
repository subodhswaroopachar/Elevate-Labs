import mysql.connector
import pandas as pd
import time

# --- Start timer ---
start_time = time.time()

# --- DB Connection ---
conn = mysql.connector.connect(
    host='localhost',
    user='subodh',         # 🔁 Replace this
    password='yourpassword', # 🔁 Replace this
    database='banking_system'
)
cursor = conn.cursor()

# --- Slightly heavier query for small table ---
query = """
SELECT *
FROM t2
WHERE amount > 1000
  AND (source_ac LIKE 'AC00%' OR destination_ac LIKE 'AC00%')
ORDER BY txn_date DESC;
"""

cursor.execute(query)
rows = cursor.fetchall()

# --- Convert to DataFrame and display ---
columns = [desc[0] for desc in cursor.description]
df = pd.DataFrame(rows, columns=columns)

print("📦 Filtered transactions (amount > 1000, AC00*, sorted by txn_date DESC):")
print(df)
df.to_csv("small_output.csv", index=False)

# --- End timer and print duration ---
end_time = time.time()
print(f"\n⏱️ Query execution time: {end_time - start_time:.4f} seconds")

cursor.close()
conn.close()
