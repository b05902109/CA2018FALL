module MEMWB
(
  input clock_i,
  input flush_i,
  input enable_i,
  input [1:0] control_WB_i,
  input [31:0] inst_i,
  input [31:0] result_i,
  input [31:0] data_i,
  output [1:0] control_WB_o,
  output [31:0] inst_o,
  output [31:0] result_o,
  output [31:0] data_o
);

reg [1:0] control_WB;
reg [31:0] inst;
reg [31:0] result;
reg [31:0] data;

reg [1:0] control_WB_buf;
reg [31:0] inst_buf;
reg [31:0] result_buf;

assign control_WB_o = control_WB;
assign inst_o = inst;
assign result_o = result;
assign data_o = data;

always @(posedge flush_i) begin
  control_WB <= 2'b0;
  inst <= 32'b0;
  result <= 32'b0;
  data <= 32'b0;
end

always @(posedge clock_i) begin
  if (enable_i) begin
    control_WB <= control_WB_buf;
    inst <= inst_buf;
    result <= result_buf;
    control_WB_buf <= control_WB_i;
    inst_buf <= inst_i;
    result_buf <= result_i;
    data <= data_i;
  end
end

endmodule
