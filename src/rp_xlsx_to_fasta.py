import pandas as pd

def excel_to_fasta(input_file, output_file):
    df = pd.read_excel(input_file)
    
    if "Position" not in df.columns or "RP Index" not in df.columns:
        raise ValueError("The required columns 'Position' and 'RP Index' are missing from the file.")
    
    with open(output_file, "w") as fasta_file:
        for _, row in df.iterrows():
            header = row["Position"]
            sequence = row["RP Index"]

            sequence = str(sequence).strip()
            
            fasta_file.write(f">{header}\n{sequence}\n")
    
    print(f"FASTA file '{output_file}' created successfully.")

excel_to_fasta("384RPIndexes.xlsx", "384RPIndexes.fasta")