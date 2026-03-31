#!/usr/bin/env python3
import psutil
#!/usr/bin/env python3
import psutil

# 1. Get user input
print("How would you like to sort the processes?")
choice = input("Enter 'C' for CPU or 'M' for Memory: ").strip().upper()

# 2. Collect process information
processes = []
for proc in psutil.process_iter(['pid', 'name', 'cpu_percent', 'memory_percent']):
    processes.append(proc.info)

# 3. Determine the sorting key
if choice == 'M':
    sort_key = 'memory_percent'
    label = "Memory %"
else:
    sort_key = 'cpu_percent'
    label = "CPU %"

# 4. Sort the list (highest first)
processes.sort(key=lambda x: x[sort_key], reverse=True)

# 5. Print the header and top 10 results
print(f"{'PID':<10} {'Name':<25} {label}")
print("-" * 45)

for p in processes[:10]:
    print(f"{p['pid']:<10} {p['name']:<25} {p[sort_key]:.2f}")
