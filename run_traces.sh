#!/usr/bin/env bash
# Get a list of all the traces in the `./traces` directory
# and run them with the command `./cvp -v -t 1 traces/trace.gz`
# where `trace.gz` is the name of the trace file.

# Get a list of all the trace files in the `./traces` directory 
# and store them in the variable `traces`
traces=$(ls traces)

# array for storing the ipc values
ipc_values=()
# Loop through each trace file in the `traces` variable
for trace in $traces
do
    # Run the trace file with the command `./cvp -v -t 1 traces/trace.gz`
    # collect the output and store it in the variable `output`
    output=$(./cvp -v -t 1 traces/$trace)
    # find the line that contains the "IPC" string
    # and store it in the variable `ipc`
    ipc=$(echo "$output" | grep "IPC")
    # get the floating point number that is the last word in the line
    # and store it in the variable `ipc_value`
    ipc_value=$(echo "$ipc" | awk '{print $NF}')
    # print the ipc value with the trace file name
    echo "$trace: IPD = $ipc_value"
    # append ipc_value to the ipc_values array
    ipc_values+=($ipc_value)
done

# print the average of the ipc_values array
echo "Average: $(echo ${ipc_values[@]} | awk '{sum=0; for(i=1; i<=NF; i++) sum+=$i; print sum/NF}')"