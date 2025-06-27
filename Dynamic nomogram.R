
绘制动态列线图
确保安装并加载所需的软件包：

```r
install.packages("survival")
install.packages("rms")
install.packages("DynNom")
install.packages("foreign")
install.packages("mice")
install.packages("Hmisc")

library(survival)
library(rms)
library(DynNom)
library(foreign)
library(mice)
library(Hmisc)


好的，我会逐步指导您使用R 4.4.1进行数据读取、处理和绘制动态Nomogram。以下是详细步骤和代码：


### 完整代码

```r
# 设置工作目录
setwd('/Users/xuxiaoxia/Desktop/R')

# 读取SPSS文件
library(foreign)
coxdata <- read.spss("AITLcox4.sav", to.data.frame = TRUE)

# 检查数据结构
str(coxdata)

# 检查缺失值
missing_data_summary <- sapply(coxdata, function(x) sum(is.na(x)))
print(missing_data_summary)

# 删除缺失值
coxdata_no_na <- na.omit(coxdata)

# 检查处理后的数据结构
str(coxdata_no_na)

# 加载所需的包
library(survival)
library(rms)

# 使用datadist函数设置数据说明符
dd <- datadist(coxdata_no_na)
options(datadist = 'dd')

# 拟合Cox比例风险模型
cox_model <- cph(Surv(time, OSstatus) ~ Albumin+Platelet+ SUVmax + β2MG, 
                 data = coxdata_no_na, 
                 x = TRUE, y = TRUE, surv = TRUE)
# 恢复默认的datadist选项
options(datadist = NULL)

# 安装并加载DynNom包
if (!requireNamespace("DynNom", quietly = TRUE)) {
  install.packages("DynNom")
}
library(DynNom)

# 创建动态Nomogram
DynNom::DynNom(cox_model, data = coxdata_no_na)
```

确保您根据您的实际数据结构对变量如`time`, `OSstatus`, `PLT`, `SUVmax`, `β2MGcut`进行调整。完成这些步骤后，您应该能够成功生成动态Nomogram。

