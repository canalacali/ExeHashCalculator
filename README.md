# ExeHashCalculator

**ExeHashCalculator** is a collection of Python and PowerShell scripts designed to calculate and analyze the MD5, SHA1, and SHA256 hash values of executable (.exe) files. These tools are particularly useful for forensic investigations and malware analysis, enabling security professionals to verify file integrity and detect potential threats.

## Features

- **Hash Calculation**: Computes MD5, SHA1, and SHA256 hash values for each executable file.
- **Forensic Use**: Ideal for use in forensic investigations where ensuring the integrity of executable files is critical.
- **Customizable Output**: Saves hash values in a well-organized `hashes.txt` file for easy reference.

## Python Script

The Python script is used for calculating hash values of executable files.

### Prerequisites

- Python 3.x
- Required Libraries: `hashlib`

### Usage

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/canalacali/ExeHashCalculator.git
   
2. **Navigate to the Directory**:
   ```sh
   cd ExeHashCalculator
   
3. **Install Required Libraries**:
   ```sh
   pip install hashlib

4. **Run the Script**:
   ```sh
   python hash_calculator.py

### Powershell Script Usage
The PowerShell script is an alternative method to achieve the same functionality.


1. **Download the Script**: Download the ExeHashCalculator.ps1 script from the repository.
   
2. **Open PowerShell as Administrator**: Ensure that you run PowerShell with administrative privileges.

3. **Set Execution Policy**: If the execution policy is not already set, configure it to allow the script to run:
   ```sh
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

4. **Run the Script**: Execute the PowerShell script:
   ```sh
   .\running_hash_calculator.ps1
