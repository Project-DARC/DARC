# Decentralized Autonomous Regulated Company (DARC) 去中心化的自动监管公司

这是 Decentralized Autonomous Regulated Company (DARC) 项目的官方代码库。DARC 是一个项目，旨在创建一个去中心化的自动监管公司，该公司由基于商业法律的插件系统监管。该项目目前处于早期开发阶段，尚未准备好用于生产环境。

[English](./README.md) | 简体中文

## 什么是 DARC?

Decentralized Autonomous Regulated Company (去中心化的自动监管公司，英文简称DARC) 是一个公司模型的虚拟机，可以编译部署到任何 EVM （以太坊虚拟机）兼容的区块链公链上，具有以下特点：

- **多级代币（Multi-level tokens）**, 每个级别的代币可以用作通用股份、优先股、特权股、债券、股票期权、董事会、商品代币、非同质化代币（NFT）等等。以上所有代币均可以有不同的价格、投票权和分红权，并且是由公司的插件系统（即法律）来定义；
- **执行程序（Program）** ，每个执行程序是由一系列的 DARC 指令组成的，包括管理代币、分红、投票、提交法律、提款、购买和其他公司日常操作；
- **分红机制（Dividend Mechanism）**，根据已有的法律协议和参数，为代币持有者提供分红；
- **插件即法律（Plugin-as-a-Law）**，插件系统就是 DARC 的公司章程与合约，监督和管理公司所有日常操作。所有公司操作需要经过插件系统，或插件系统定义的投票程序的批准后，才能成功执行。

## By-Law Script（章程语言）

By-law Script（章程语言）是一个类似于 JavaScript 语法的编程语言，可以用来定义公司的章程、规则、合约和 DARC 上的公司管理操作。例如：

```javascript
mint_tokens(   // 铸造代币
  [addr1, addr2, addr3],   // 铸造代币发往的地址
  [0, 0, 0],   // 代币等级
  [500, 300, 200]]  // 铸造代币数量
);

pay_cash(100000000, 0, 1); // 支付 0.1 ETH 作为客户采购

transfer_tokens(   // 转让代币
  [addr1, addr2, addr3],   // 代币转让的目标地址
  [0, 0, 0],   // 代币等级
  [100, 100, 200]]  // 代币数量
);

add_withdraw_cash(10000000);  // 申请 0.01 ETH 的提款

withdraw_cash_to(  // 把我的账户中的 ETH 提款到对应地址
  [addr4, addr5],       // 提款地址
  [10000000, 10000000]  // 提款金额： 0.01 ETH, 0.01 ETH
);  


```

以上 By-law Script 代码将被转译并解释运行在 DARC 虚拟机的智能合约上。如果以上代码全部被 DARC 插件系统批准，那么将会被执行。如果有任何一条指令被插件系统拒绝，那么整个程序（Program）操作都会被拒绝。

如果需要添加插件和投票规则，我们可以简单地写成插件和投票规则，并且通过 `add_voting_rule()` 或 `add_and_enable_plugins()` 或 `add_plugins()` 操作来发送到 DARC 虚拟机的智能合约上，如果当前的插件系统批准了这些操作，那么这些插件和投票规则将会被部署并立即生效。

下面是一个简单快速的例子。假设我们需要限制大股东（>25%）的代币转让，需要董事会进行全体投票（假设总共5票），并且需要 1 小时内 100% 的投票通过（5票中必须有5票投票通过）。我们可以通过添加一个新的插件和相应的投票规则到 DARC 虚拟机的智能合约上：


```javascript
add_voting_rule(  // 新增投票规则(序号为 5)
  [
    {
      voting_class: [1], // 投票代币等级：1级代币，即公司董事会被要求投票
      approve_percentage: 99,  // 投票通过需要 >= 99% 的投票权通过
      voting_duration: 3600,  // 投票时常：1 小时
      execute_duration: 3600,  // 投票通过后，执行操作的时常：1 小时
      is_absolute_majority: true,  // 绝对多数投票制（而不是相对多数制）
    }
  ]
)

add_and_enable_plugins(  // 新增插件并立即生效
  [
    {
      condition: // 定义插件生效条件
        (operation == "transfer_tokens")   // 如果是代币转让操作
        & (operator_total_voting_power_percentage > 25), // 并且操作者地址的投票权 > 25%
      return_type: vote_needed,  // 返回类型：需要投票
      return_level: 100,  // 优先级：100
      votingRuleIndex: 5 // 使用投票规则序号为 5 的投票规则（即 100% 的董事会成员们必须投票通过）
      note: "100% Approval is needed by board members to transfer tokens by major shareholders (>25%)"
      is_before_operation: false,  // 是否在沙箱（sandbox）试运行之前检查执行：否（这个插件要求在沙箱（sandbox）试运行之后检查执行）
    }
  ]
)
```

执行以上的 By-law Script 程序后，DARC VM 合约将添加一个新的插件和投票规则，并且插件将立即生效（如果存在与 add_voting_rule() 和 add_and_enable_plugins() 相关的任何投票程序，则插件将在投票流程通过后生效）。如果操作员（addr1）尝试将代币转移给 addr2，插件将检查条件并返回 vote_needed 给 DARC VM 合约，DARC VM 合约将要求董事会（一级代币所有者）进行投票。如果董事会批准该操作，则该操作将在沙盒中执行，否则该操作将被拒绝。例如，如果触发了3个投票规则，则投票操作将是：

```javascript
vote([true, true, true])
```

如果现有的投票规则和插件批准了投票过程，则新程序将被批准在下一个执行等待期（例如1小时）内执行，程序所有者或任何其他成员可以在下一个1小时内执行该程序，否则该程序将被忽略并从待处理列表中移除。

## “插件即法律”（"Plugin-as-a-Law"）

在 DARC 中，法律是由以下伪代码来定义的：

```javascript
if (插件条件 == true) {
  插件决定 = 批准/拒绝/等待投票
}
```

每个插件中，都包含一个条件树（condition expression tree）和一个决策（返回类型）。当在程序（Program）运行之前提交程序时，如果条件树被评估为真(true)，则插件将做出决策：允许、拒绝或要求进行投票。例如：


### 例1: 反稀释股权

在公司法律中，反稀释股份是一个基本机制，可以防止公司（也包括 DAO 和其他链上的“代币经济学”）发行过多的股份，从而稀释削弱掉现有股东们的股权和利益。在 DARC 中，公司和早期投资者们可以定义一个“反稀释股份”的法律，并且同时制定一个特定的流程来在适当时候废除掉这条法律。

***法律条款1 (反稀释股权法): 股东X应当永久持有该公司的10%股份***

*插件设计思路: 如果操作者（operation）增发了0级代币（公司普通股），则插件应该检查代币的持有者（token ownerships），X应该永远保持10%的总投票权和10%的分红权*


在 By-law Script 的语法中，我们可以如下定义这个条件和法律:

```javascript
// 定义 X 的地址
const x_addr = "0x1234567890123456789012345678901234567890";  

// 定义插件
const anti_delutive = {

  // 定义出发条件
  condition: 
    ( (operation == "mint_tokens")             // 如果正在“增发代币”
     | (operation == "pay_to_mint_tokens") )   // 或者正在“付费增发代币”
    &                                          // 并且       
    ( (total_voting_power_percentage(x) < 10)    // X的总投票权 < 10%
      | (total_dividend_power_percentage(x) < 10) ),   // 或者 X的总分红权 < 10%

  // 定义插件决策：否决该操作
  return_type: NO,

  // 定义优先级：100
  return_level: 100,

  // 是否在沙箱（sandbox）试运行之前检查执行：否（这个插件要求在沙箱试运行之后检查执行）
  is_before_operation: false,  
}
```

由于这个插件需要检查代币所有权的状态，因此应该在 DARC 沙盒中执行操作后执行插件。如果插件的条件被评估为真，则当这个程序（Program）在沙箱（sandbox）执行后会被拒绝，并且该操作将被拒绝在真实环境中执行。否则，将允许“铸造新代币”执行。


当将此插件添加到 DARC 中时，操作员（operator，也就是当前程序的提交者）必须铸造额外的代币并将其发送到 x_addr 地址，以满足上述的**法律条款1**，否则操作将被拒绝。例如，DARC 只有一级代币（级别 0，投票权 = 1，红利权 = 1），股权情况如下：

| 股东  | 持股数量 | 百分比 |
| ------------- | ------------- | ------------- |
| CEO | 400  | 40% |
| CTO  | 300  | 30% |
| CFO  | 200  | 20% |
| VC X  | 100  | 10% |
| **总共** | **1000** | **100%** |

如果操作员想要铸造 200 个代币并将它们发放给 VC Y，则操作员必须铸造 20 个代币并将它们发送到 x_addr 地址，以满足上述的**法律条款1**，否则该操作将被拒绝。以下是 VC Y 提供的示例投资方案：

```javascript
pay_cash(1000000000000)  // 支付 1000 ETH 给 DARC
mint_tokens(20, 0, x_addr)  // 增发 20 个 0 级代币给 x_addr
mint_tokens(180, 0, y_addr)  // 增发 180 个 0 级代币给 y_addr
add_and_enable_plugin([new_law_1, new_law_2, new_law_3])  // VC Y 提出了新的法律
```

在以上操作后，股权情况如下：:

| 股东  | 持股数量 | 百分比 |
| ------------- | ------------- | ------------- |
| CEO | 400  | 33.33% |
| CTO  | 300  | 25% |
| CFO  | 200  | 16.67% |
| VC X  | 120  | 10% |
| VC Y  | 180  | 15% |
| **总共** | **1200** | 100% |

与此同时，另一个插件也应该添加到 DARC 中，以定义“废除法律1”的法律流程：

***法律条款1.1 (法律条款1附录): 如果废除法律1和法律1附录（当前的法律），当且仅当操作者是 X***

*插件设计思路: 如果操作是“disable_plugins”，并且企图被废除的法律条款序号是 `id == 1` 或者 `id == 2`，并且操作者不是 X，则插件应该拒绝该操作（假设反稀释法律索引为 1，法律1附录索引为 2，两者都是在操作之前的插件）*

```javascript
const law_1_appendix = {

  // 定义法律触发条件
  condition: 
    (operation == "disable_plugins") 
    & ( (disable_after_op_plugin_id == 1) | (disable_after_op_plugin_id == 2) )
    & (operator != x_addr),

  // 定义插件决策
  return_type: no,

  // 定义优先级
  return_level: 100,

  // 在沙箱试运行之前检查执行：是
  is_before_operation: true, 
}
```



### 例2: 对赌协议（Bet-on Agreement，或者称为Valuation-Adjustment Mechanism(VAM) Agreement）

***法律条文2: 如果在2035年1月1日之前，总共营收（revenue）少于1000 ETH，那么股东X可以获得超过75%的投票权和90%的分红权***

***Law2: If total revenue < 1000 ETH by 2035/01/01, shareholder X can take over 75% of total voting power and 90% of dividend power.***

*插件设计思路：在沙箱（sandbox）操作之后，检查以下条件：*

- *时间戳（timestamp）>= 2035/01/01*

- *自 2000/01/01 起的总收入 < 1000 ETH*

- *操作为 "mint_tokens"*

- *x 的总投票权 <= 75%*

- *x 的红利权 <= 90%*

*那么插件应该批准该操作*

在 By-law 脚本中，我们可以定义上述插件如下：

```javascript
const bet_on_2 = {
  
    // 定义该插件的触发条件
    condition: 
      (timestamp >= toTimestamp('2035/01/01')) &
      (revenue_since(946706400) < 1000000000000) & // 1000000000000 Gwei = 1000 ETH
      (operation == "mint_tokens") &
      (total_voting_power_percentage(x) < 75) &
      (total_dividend_power_percentage(x) < 90),
  
    // 定义最终决策
    return_type: yes,
  
    // 定义优先级
    return_level: 100,

    // 在沙箱试运行之后检查执行：是
    is_before_operation: false,
}
```

### 例3: 员工工资

***法律条文3: 对于级别为 X 的员工，每个月可以领 10 ETH 现金作为工资***

*插件设计思路：如果操作是“添加可提款现金”，并且添加现金数量少于 10 ETH，并且该地址操作员（operator）上次操作在 30 天之前，那么这个操作应该在沙箱（sandbox）运行之前直接批准，并且跳过沙箱检查*

在 By-law Script 程序中，我们可以定义具有以下条件的插件（例如，级别 X = 2 可以每 30 天提取 10 ETH）：

```javascript
const payroll_law_level_2 = {
  condition: 
    (operation == "add_withdrawable_cash") &   // 操作指令是 "add withdrawable cash"
    (member_role_level == 2) &   // operator 操作程序的作者是级别为 2 的成员

    // 并且操作员上次执行 “add_withdrawable_cash” 的时间是 30 天 = 2592000 秒
    (operator_last_operation_window( "add_withdrawable_cash") >= 2592000) &  
    // 并且本次添加金额 < 10000000000 Gwei = 10 ETH
    (add_withdrawable_cash_amount <= 10000000000),  
  return_type: yes_and_skip_sandbox,
  return_level: 1
  is_before_operation: true, //在沙箱检查之前直接允许
}
```

使用上述插件，操作员（即员工）可以将可提取现金添加到员工帐户中，金额小于或等于 10 ETH，上一个操作至少在 30 天之前。插件将批准操作并跳过沙盒检查。当员工地址被禁用、从角色级别 X 中删除或其他优先级更高的插件拒绝操作时，这些操作将被拒绝。

### 例4: 投票与立法

"对于日常运营，董事会可以定义为一组地址，并使用投票机制做出决策。例如，让我们为以下情景设计投票机制：

1. 对于拥有超过10％总投票权的地址X，能通过铸造1个代币（代币级别为2，也就是董事会投票代币）的方式，添加到董事会，但前提是该行为经过董事会三分之二成员的批准（即依据投票规则1进行投票）。

```javascript
const add_board_member = {
  condition: 
    (operation == "mint_tokens") &   // 操作等于 "增发代币"
    (mint_tokens_level == 2) &  // 增发代币级别为2
    (mint_tokens_amount == 1) &  // 增发数量为1
    (operator_total_voting_power_percentage >= 10),   // 操作者拥有的总投票权大于等于10%

  // 插件决策：需要投票
  return_type: vote_needed,
  voting_rule: 1,  // 在决策投票规则1下，超过2/3的董事会成员批准该操作，则该操作被批准
  return_level: 100,
  is_before_operation: false, // 沙箱检查之后才进行投票
}
```

2. 任何持有超过所有投票权7%的用户地址，都可以提交`enable_plugins()`指令，但需要获得所有董事会成员100%的批准。每个用户可以每隔10天尝试使用这条指令一次。

```javascript
const enable_plugin = {
  condition:
    (operation == "enable_plugins") &   // 操作是 "enable_plugins()"
    (operator_total_voting_power_percentage >= 7) &   // 该用户拥有的总投票权大于等于7%
    (operator_last_operation_window("enable_plugin") >= 864000),  //每个用户可以每 864000 seconds (10 days) 天尝试一次

  return_type: vote_needed,
  voting_rule: 2,  // 在投票规则2下，超过所有董事会成员的100%批准该操作，则该操作被批准
  return_level: 100,
  is_before_operation: false, // 沙箱检查之后才进行投票
}
```

3. 要禁用插件2、3和4，程序操作者需要持有总投票权的至少20%，并且操作需要获得所有普通股代币（级别为0的代币）所有投票人的70%的相对多数（投票规则2）批准。对于DARC的每个成员，该操作每15天（1296000秒）可以执行一次。

```javascript
const disable_2_3_4 = {
  condition:
    (operation == "disable_plugins") &   // 发起操作是 "disable_plugins"
    (
        disable_after_op_plugin_id == 2 
        | disable_after_op_plugin_id == 3 
        | disable_after_op_plugin_id == 4
    ) &  // 废除插件2、3 或者 4
    (operator_total_voting_power_percentage >= 20) &   // 操作者拥有的总投票权大于等于20%
    (operator_last_operation_window("disable_plugins") >= 1296000),  // 每个用户可以每 1296000 seconds (15 days) 天尝试一次
  return_type: vote_needed,
  voting_rule: 3,  // 在投票规则3下，超过所有普通股代币（级别为0的代币）所有投票人的70%的相对多数批准该操作，则该操作被批准
  is_before_operation: false, // 沙箱检查之后才进行投票
}
```

### 例5: 多级代币：商品代币和非同质化代币（NFT）

以下是如何设计一个拥有不同投票和分红权力级别的代币的示例。投票权(voting power)和分红权(dividend power)用于计算每个代币持有者的投票权和分红权。以下是一个代币级别的表格：

| 等级 | 代币 | 投票权 | 分红权 | 总币供应量 |
| --- | --- | --- | --- | --- |
| 0 | 0级普通股份（Level-0 Common Stock） | 1 | 1 | 100,000 |
| 1 | 1级特别表决权股份（Level-1 Stock） | 20 | 1 | 10,000 |
| 2 | 董事会成员票（Board of Directors） | 1 | 0 | 5 |
| 3 | 行政人员投票权（Executives） | 1 | 0 | 5 |
| 4 | 非投票股份（Non-Voting Shares） | 0 | 1 | 200,000 |
| 5 | 商品代币A（Product Token A） 价格是0.01 ETH/个 | 0 | 0 | ∞ |
| 5 | 商品代币B（Product Token B） 价格是 10 ETH/个 | 0 | 0 | ∞ |
| 7 | Non-Fungible Token #1 | 0 | 0 | 1 |
| 8 | Non-Fungible Token #2 | 0 | 0 | 1 |
| 9 | Non-Fungible Token #3 | 0 | 0 | 1 |
| 10 | Non-Fungible Token #4 | 0 | 0 | 1 |
| 11 | Non-Fungible Token #5 | 0 | 0 | 1 |
| ... | ... | ... | ... | ... |

为了支付服务或购买产品，客户可以使用`pay_cash()`直接支付服务费用，或使用 `pay_to_mint_tokens()`作为支付方式并获得商品代币/非同质化代币（NFT）。

这里给一个简单的例子，来定义同质化商品代币A以及NFT的价格法则和总代币供应量。

```javascript
const product_token_A_price_law = {
  condition:
    (operation == "pay_to_mint_tokens") &   // 操作指令是 "pay_to_mint_tokens"
    (pay_to_mint_tokens_level == 5) &  // 代币级别是5
    (pay_to_mint_price_per_token >= 10000000000000000),   // 每个代币价格 >= 0.01 ETH = 10000000000000000 wei

  return_type: yes_and_skip_sandbox,  // 准许操作并跳过沙箱检查
  return_level: 1,
  is_before_operation: true, // 在沙箱运行检查前执行本插件
}

const NFT_price_law = {
  condition:
    (operation == "pay_to_mint_tokens") &   // 操作指令是 "pay_to_mint_tokens"
    (pay_to_mint_tokens_level >= 7) &  // 代币级别是7或者更高
    (pay_to_mint_token_amount == 1) &  // 代币只能一次性付费铸造一个
    (pay_to_mint_current_level_total_supply == 0) &  // 目前总代币供应量为0
    (pay_to_mint_price_per_token >= 10000000000000000000),   // 每枚代币价格 >= 10 ETH = 10000000000000000000 wei

  return_type: yes_and_skip_sandbox,  // 准许操作并跳过沙箱检查
  return_level: 1,
  is_before_operation: true, // 在沙箱运行检查前执行本插件
}
```

### 例6: 在 5 年内锁定分红比率 

股息机制是根据一定规则向代币持有者分配股息的设计：

每进行 X 笔购买交易，将总收入的 Y‱ 设为可分配股息的现金
可以调用 offer_dividend() 操作，将可分配股息的现金分配给代币持有者的股息提取余额
每个代币持有者（X）的股息金额计算公式如下：dividend_X = dividendable_cash * dividend_power(X) / total_dividend_power
在调用 offer_dividend() 操作后，可分配股息的现金和可分配股息交易计数器将被设置为0，并且每个代币持有者的股息提取余额将增加 dividend_X
为了确保股息收益率稳定，我们可以添加一个插件到 DARC 中，通过限制 set_parameters() 函数来锁定股息收益率5年。

***法律条文6: 在 2030-01-01 之前，本实体的收入分红比率必须保持 > 500‱ (5%) 以上***

```javascript
const dividend_yield_rate_law = {
  condition: 
    (operation == "set_parameters") &  // 操作指令是 "set_parameters"
    (set_parameters_key == "dividentPermyriadPerTransaction") &  // 设置参数的键值为 "dividend_yield_rate"
    (set_parameters_value < 500) &  // the value is < 500‱ (5%)
    (timestamp < 1893477600),  // 时间戳小于 < unix timestamp  2030-01-01 00:00:00 (UTC) 
  
  return_type: no,  // 拒绝这个操作
  return_level: 1,
  is_before_operation: true, // 在进入沙箱检查前执行本插件
}
```

### 例7: 一个投资计划项目

这里提供一个非正式的**未来股权简单协议（Simple agreement for future equity，或者简称SAFE）**。这种协议经常被风险投资机构用来当作投资合同:

1. 本 VC 同意支付 1000 ETH (1000000000000 Gwei) 现金作为投资
2. 本 VC 将会获得 100,000,000 枚 level-0 代币 (普通股份) 和 1 枚 level-2 代币 (作为董事会成员投票权代币)
3. 本 VC 将会被允许批准废除已有的 5, 6, 7 三条法律
4. 本 VC 将会被允许批准提交 8, 9, 10, 11 四条法律，并当即生效
5. 本 VC 将会被允许在公司名录概念中加入为 5 级成员权限 (主要大股东成员权限)
6. 我们通常建议扫描并签字一份电子版的文字 PDF 文档，作为本次交易的记录，上传这份 PDF 文档到 IPFS 上面，并且把 IPFS 对应的 hash value `QmcpxHN3a5HYnPurtuDs3jDfDSg1LPDe2KVBUG4RifcSbC` 加入到 DARC 的永久存储数组中。这样可以帮助紧急代理人（Emergency Agent）在需要的时候，验证并修复 DARC 技术问题。


```javascript
const vc_addr = "0x1234567890123456789012345678901234567890";  // 定义 VC 地址

pay_cash(1000000000000, 0, 1);  // 支付 1000 ETH = 1000000000000 Gwei cash

mint_token([vc_addr], [100000000], [0]);  // 增发 100,000,000 level-0 tokens (common stock) 给 VC

mint_token([vc_addr], [1], [2]);  // 增发一枚 2-level token (董事会成员) 给 VC

disable_plugins([5,6,7], [false, false, false]) // 取消合同 5, 6, 7

enable_plugins([8,9,10,11], [false, false, false, false]) // 增加合同 8, 9, 10, 11

change_member_role(vc_addr, 5);  // 把 VC 加入到公司名录概念中，作为 5 级成员权限 (主要大股东成员权限)

// 把 PDF 文档的 IPFS hash 加入到 DARC 的永久存储数组中
add_storage(['QmcpxHN3a5HYnPurtuDs3jDfDSg1LPDe2KVBUG4RifcSbC']);
```

## Building the source

Since Hardhat and OpenZeppelin are used, the project can be built using the following commands:

1. Install dependencies

```shell
npm install
```

2. Compile the contracts

```shell
npx hardhat compile
```

3. Deploy and test the contracts

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```