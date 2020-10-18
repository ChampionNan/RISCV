实验二说明文档
=====================

## 验收标准

* 本次实验验收只要求仿真（Simulation）结果正确，不要求综合和烧板子。
* 验收分三个阶段，阶段二的测试如果能通过，默认阶段一已完成。阶段三的CSR指令需另行测试。如果不能完成整个实验，最后按完成阶段给分。

## 代码说明

* 三个目录Simulation、SourceCode、TestDataTools分别包含了仿真文件及测试数据、源代码、测试数据生成工具。
* 由于Vivado的编辑器存在中文编码问题，推荐在VScode环境下开发代码。
* 源代码均有注释，说明了模块功能、接口作用、是否需要补全，请参考注释完成RV32I Core
* 阶段二的测试可以参考General Register的3号寄存器，它的值代表执行到第几个test，全部测试通过，3号寄存器的值最终变为1

## 使用说明

* 以Vivado开发为例，新建工程，将SourceCode的代码导入，Simulation文件夹下的testBench.v作为仿真文件导入，并将testBench.v设置为Simulation的Top文件。之后直接进行仿真即可，会自动将.inst和.data的文件加载进Instruction Cache和Data Cache，并开始执行。
* testBench.v定义的四个宏：`DataCacheContentLoadPath, InstCacheContentLoadPath, DataCacheContentSavePath, InstCacheContentSavePath `，分别是Data Cache、Instruction Cache的写入文件路径，及Data Cache、Instruction Cache导出内容路径，请根据需要自行修改。
* TestDataTools的工具使用说明，请参考文件夹的Readme文档

