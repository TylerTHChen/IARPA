module waves(
    input clk, // clock
    output logic GDS, // GDS Wave
    output logic QMOD // QMOD Wave
);

    // Define parameters for the size of waveforms and bit sequence
    parameter BIT = 2498; 
    parameter WAVE = 8;

    // Sequence
    logic [WAVE-1:0] seq;
    assign seq = 8'b1001_0101;

    logic bit0[0:BIT-1];
    logic bit1[0:BIT-1];
    logic QM[0:BIT-1];

    // Initial block to load data from CSV files
    initial begin 
        $readmemb("GDS_0_50_d15_35_d10_30_d10_27_1.0u_100k.csv", bit0);
        $readmemb("GDS_1_50_d15_35_d10_30_d10_27_1.0u_100k.csv", bit1);
        $readmemb("Qmod_1.0u_100k_2498.csv",QM);
    end

    // Counters
    integer bit_cnt = 0; 
    integer wave_cnt = 0;       

    // Always block to generate waveforms
    always @(posedge clk) begin
        if (bit_cnt < BIT) begin
            if (seq[wave_cnt] == 1'b1) begin
                GDS <= bit1[bit_cnt];
            end else begin
                GDS <= bit0[bit_cnt];
            end
            QMOD <= QM[bit_cnt];
            bit_cnt <= bit_cnt + 1;
            if (bit_cnt == BIT) begin
                bit_cnt <= 0;
                if(wave_cnt == WAVE)
                    wave_cnt <= 0;
                else
                    wave_cnt <= wave_cnt + 1;
            end
        end else begin
            // Reset counters when the sequence is complete
            bit_cnt <= 0;
            wave_cnt <= 0;
        end
    end
endmodule
