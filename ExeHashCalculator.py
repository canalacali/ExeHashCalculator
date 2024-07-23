import os
import hashlib
import psutil

def calculate_hashes(file_path):
    hashes = {'MD5': hashlib.md5(), 'SHA1': hashlib.sha1(), 'SHA256': hashlib.sha256()}
    try:
        with open(file_path, 'rb') as f:
            while chunk := f.read(8192):
                for hash_algo in hashes.values():
                    hash_algo.update(chunk)
        return {name: hash_algo.hexdigest() for name, hash_algo in hashes.items()}
    except Exception as e:
        print(f"Error calculating hashes for {file_path}: {e}")
        return None

def get_running_exe_files():
    exe_files = []
    for proc in psutil.process_iter(['pid', 'name', 'exe']):
        try:
            if proc.info['exe'] and proc.info['exe'].endswith('.exe'):
                exe_files.append(proc.info['exe'])
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    return exe_files

def main():
    exe_files = get_running_exe_files()
    
    if not exe_files:
        print("No running .exe files found.")
        return
    
    output_directory = input("Please enter the directory to save hashes.txt: ")
    output_path = os.path.join(output_directory, 'hashes.txt')
    
    with open(output_path, 'w') as output_file:
        for exe_file in exe_files:
            output_file.write(f"File: {exe_file}\n")
            hashes = calculate_hashes(exe_file)
            if hashes:
                output_file.write(f"MD5: {hashes['MD5']}\n")
                output_file.write(f"SHA1: {hashes['SHA1']}\n")
                output_file.write(f"SHA256: {hashes['SHA256']}\n")
            output_file.write("-" * 60 + "\n")
    
    print(f"Hash values have been written to {output_path}")

if __name__ == "__main__":
    main()
