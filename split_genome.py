#split_genome.py
def split_fasta_sequence(input_file, output_file, n):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    sequences = {}
    current_sequence = ''
    current_header = ''
    for line in lines:
        if line.startswith('>'):
            if current_sequence:
                sequences[current_header] = current_sequence
                current_sequence = ''
            current_header = line.strip()
        else:
            current_sequence += line.strip()

    if current_sequence:
        sequences[current_header] = current_sequence

    with open(output_file, 'w') as f:
        for header, sequence in sequences.items():
            num_splits = len(sequence) // n
            for i in range(num_splits):
                start = i * n
                end = (i + 1) * n
                f.write(f'{header}_split_{i+1}\n')
                f.write(f'{sequence[start:end]}\n')

            if len(sequence) % n != 0:
                start = num_splits * n
                f.write(f'{header}_split_{num_splits+1}\n')
                f.write(f'{sequence[start:]}\n')
import sys
#input_file = 'input.fasta'
input_file = sys.argv[1]
#output_file = 'output.fasta'
output_file = sys.argv[2]
#n = 18000
n = int(sys.argv[3])
split_fasta_sequence(input_file, output_file, n)
