
def Ducci_seq(input_set):
    
    sequences = set();
    while sum(input_set) != 0:
        
        #Add the current sequence to the sequences set
        sequences.add(input_set);

        #New sequence
        sequence = ();

        #calculate and add the values to tuple
        for i in range(len(input_set) - 1):
            sequence = sequence + (abs(input_set[i + 1] - input_set[i]),);
        sequence = sequence + (abs(input_set[len(input_set) - 1] - input_set[0]),); #Add the last entry
        
        input_set = sequence;
        print(input_set);

    return len(sequences);


print(Ducci_seq((0, 653, 1854, 4063)))

