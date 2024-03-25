# Decentralized Autonomous Regulated Company (DARC)

Decentralized Autonomous Regulated Company (DARC) プロジェクトの公式リポジトリへようこそ。DARC は、
商法に基づくプラグインシステムによって規制される分散型自律企業の創設を目指すプロジェクトである。
このプロジェクトは現在、開発の初期段階にあり、まだ生産に使用できる段階ではありません。

[English](./README.md) | [简体中文](./README_cn.md) | 日本語

## コミュニティに参加

Telegram: [https://t.me/projectdarc](https://t.me/projectdarc)

## DARC とは?

Decentralized Autonomous Regulated Company (DARC) は、EVM 互換のブロックチェーンにコンパイルしてデプロイできる企業仮想マシンで、次のような特徴があります:

- **Multi-level tokens** 各レベルのトークンは、普通株式、優先株式、転換社債、取締役会、製品トークン、非可菌トークン（NFT）として使用することができ、価格、議決権、配当権は会社のプラグイン（法）システムによって定義されます。
- **Program** トークンの管理、配当、投票、立法、購入、現金の引き出し、その他の企業運営を含む一連のDARC指示で構成される。
- **Dividend Mechanism** 一定の規則に従ってトークン保有者に配当金を分配する。
- **Plugin-as-a-Law** プラグインシステムは、すべてのオペレーションを監督する規約や商業契約の役割を果たす。
  会社の運営はすべて、プラグインシステムまたはそれに対応する投票プロセスによって承認される必要がある。

## By-Law Script

By-law Script は JavaScript のようなプログラミング言語であり、DARC 上での会社の商業ルールやオペレーションを定義するために使用されます。例えば:

```javascript
mint_tokens(   // ミントのトークン操作
    [addr1, addr2, addr3],   // トークンアドレス
    [0, 0, 0],   // トークンクラス
    [500, 300, 200]  // トークン数
);

pay_cash(100000000, 0, 1); // 0.1 ETH を購入代金として支払う

transfer_tokens(   // 転送トークン操作
    [addr1, addr2, addr3],   // トークンアドレス
    [0, 0, 0],   // トークンクラス
    [100, 100, 200]  // トークン数
);

add_withdraw_cash(10000000);  // 0.01 ETH を引き出し残高に追加する

withdraw_cash_to(  // 自分の口座から他のアドレスに現金を引き出す
    [addr4, addr5],       // 現金を addr4、addr5 に引き出す
    [10000000, 10000000]  // 引き出し額 0.01 ETH, 0.01 ETH
);


```

上記付則のスクリプトはコードジェネレーターで変換され、対応する DARC の VM 契約に送られます。プラグインシステムが承認すれば、DARC はプログラムを実行します。
DARC にプラグインと投票ルールを追加するには、単純にプラグイン条件と投票ルールを組み合わせ `add_voting_rule()`、`add_and_enable_plugins()`、`add_plugins()` の操作で送信します
そして、現在のプラグインシステムがその操作を承認すれば、即座にデプロイされ、有効になる。

ここで簡単な例を挙げます。取締役会にオールハンド投票（全部で 5 つのトークンを想定）を求めることで、大株主（25％ 以上）によるトークンの譲渡を制限する必要があり、1 時間以内に 100％ の承認（5 人中 5 人）が必要だとします。
DARC VM 契約に新しいプラグインと対応する投票ルールを追加することができます:

```javascript
add_voting_rule(  // 投票ルールを追加する（インデックス 5 として）
    [
        {
            voting_class: [1], // 投票トークンクラス: 1、レベル 1 のトークン所有者（取締役会）には投票義務がある
            approve_percentage: 99,  // 承認には 99％ の議決権が必要
            voting_duration: 3600,  // 投票時間: 1 時間（3600 秒）
            execute_duration: 3600,  // 実行保留期間: 1 時間（3600 秒）
            is_absolute_majority: true,  // 相対多数ではなく絶対多数が必要
        }
    ]
)

add_and_enable_plugins(   // プラグインの追加と有効化（インデックス 7 と同様）
    [
        {
            condition:  // 条件を定義する:
                (operation == "transfer_tokens")   // 操作が transfer_tokens の場合
                & (operator_total_voting_power_percentage > 25),  // かつ addr1 の議決権 >25
            return_type: voting_needed,  // 戻り値の型: 要投票
            return_level: 100,  // 優先度: 100
            votingRuleIndex: 5 // 投票規則インデックス 5（取締役会に投票を依頼し、100％ 賛成しなければならない）
            note: "100% Approval is needed by board members to transfer tokens by major shareholders (>25%)"
            is_before_operation: false,  // サンドボックス内で操作が実行された後、プラグインをチェックする
        }
    ]
)
```

上記のBy-Lawスクリプトが実行されると、DARC VMコントラクトは新しいプラグインと投票規則を追加し、プラグインは直ちに有効となる
（`add_voting_rule()` と `add_and_enable_plugins()` に関連する投票手続きが存在する場合、プラグインは投票手続きが承認された後に有効となる）。
オペレータ(`addr1`)が addr2 にトークンを転送しようとすると、プラグインはその条件をチェックして `voting_needed` を DARC VM 契約に返し、
DARC VM 契約は理事会(レベル 1 のトークン所有者)に投票を依頼する。理事会が承認すれば、サンドボックス内で作戦が実行され、そうでなければ作戦は却下される。
例えば、3 つの投票ルールがトリガーされた場合、投票操作は次のようになる:

```javascript
vote([true, true, true])
```

投票プロセスが既存の投票ルールとプラグインによって承認された場合、新しいプログラムは次の実行保留期間（この例では 1 時間）
での実行が承認され、プログラム所有者または他のメンバーは次の1時間以内にプログラムを実行することができます。

## "Plugin-as-a-Law"

DARC の法的規定は以下の擬似コードで定義される:

```javascript
if (plugin_condition == true) {
    plugin_decision = allows / denies / requires a vote
}
```

各プラグインには、条件式ツリーと対応するデシジョン（戻り値の型）が含まれる。実行前にプログラムがサブミットされている間に
条件ツリーが真と評価されると、プラグインは許可、拒否、または投票を要求する決定を下す。例えば:

### 例 1: 希薄化防止株式

希薄化防止株式とは、企業（DAO や他のオンチェーン「トークノミクス」を含む）が株式を発行しすぎて、既存株主の所有権が希薄化するのを防ぐための基本的な仕組みである。
DARC では、企業とアーリーステージの投資家は "反希薄化株式" の法的規定を定義することができ、一定のプロセスを経て法的規定を廃止することができる。

***法的規定 1 (希薄化防止株式): 株主 X は常に全株式の 10％ を保有しているはずである。***

*プラグインの設計: オペレーションが新しいレベル 0 トークンを鋳造する場合、プラグインはトークンの所有者の状態をチェックし、
X はオペレーション実行後、常に 10％ の総議決権および 10％ の配当権を最低限維持すべきである。*

By-Law script では、以下の条件でプラグインを定義することができる:

```javascript
// X のアドレスを定義する
const x_addr = "0x1234567890123456789012345678901234567890";

// プラグインを定義する
const anti_delutive = {

    // トリガー条件を定義する
    condition:
        ((operation == "mint_tokens")             // オペレータが新しいトークンをミントしている場合
            | (operation == "pay_to_mint_tokens"))   // またはオペレータが新しいトークンをミントするために支払っている
        &                                          // 及び
        ((total_voting_power_percentage(x) < 10)    // X の総議決権 <10
            | (total_dividend_power_percentage(x) < 10)),   // または X の配当総額 <10

    // 決断の定義: 操作の拒否
    return_type: NO,

    // 優先順位の定義: 100
    return_level: 100,

    // サンドボックス内で操作が実行された後、プラグインをチェックする
    is_before_operation: false,
}
```

このプラグインはトークン所有権の状態をチェックするため、DARCのサンドボックス内で操作が実行された後に実行されなければならない。
プラグインの条件がtrueと評価された場合、プラグインはサンドボックス内で実行した後に操作を拒否し、実際の環境での実行は拒否されます。
そうでなければ、"minting new tokens" の実行が許可される。

このプラグインが DARC に追加された場合、オペレーター（現在のプログラムの作者）は、上記の**法的規定 1** を満たすために、アドレス `x_addr` に余分なトークンを追加しなければならない。
例えば、DARC には 1 つのレベルのトークンしかなく（レベル 0、議決権 = 1、配当権 = 1）、株式の所有権は次のとおりである:

| 株式所有者     | トークン数         | 比率       |
|--------------|------------------|------------|
| CEO          | 400              | 40%        |
| CTO          | 300              | 30%        |
| CFO          | 200              | 20%        |
| VC X         | 100              | 10%        |
| **合計**     | **1000**         | **100%**   |

オペレータが 200 トークンをミントして VC Y に発行したい場合、上記の**法的規定 1** を満たすために、オペレータはアドレス `x_addr` に 20 トークンを鋳造しなければならない。
以下は VC Y による投資プログラムのサンプルである:

```javascript
pay_cash(1000000000000)  // DARC に 1000 ETH を支払う
mint_tokens(20, 0, x_addr)  // レベル 0 トークン 20 個をアドレスx_addr にミントする
mint_tokens(180, 0, y_addr)  // レベル 0 トークン 180 個をアドレスy_addr にミントする
add_and_enable_plugin([new_law_1, new_law_2, new_law_3])  // VC Yによる投資法
```

手術後、株式の所有権は次のようになる:

| 株式所有者     | トークン数         | 比率       |
|--------------|------------------|------------|
| CEO          | 400              | 33.33%     |
| CTO          | 300              | 25%        |
| CFO          | 200              | 16.67%     |
| VC X         | 120              | 10%        |
| VC Y         | 180              | 15%        |
| **合計**     | **1200**         | 100%       |

また、"廃止法 1"の立法を定義するために、DARC に別のプラグインを追加すべきである:

***法的規定 1.1(法的規定 1 Appendix): 法的規定 1 と法則付則 1（現行法的規定）の両方が廃止できるのは、オペレータが X である場合に限られる***

*プラグインの設計: 操作が "disable_plugins" で、無効にするプラグインが `id == 1` または `id == 2` で、操作者が X でない場合、プラグインは操作を拒否するはずです（希釈防止法のインデックスが 1、付録法のインデックスが 2 で、どちらも操作前のプラグインであると仮定します）*

```javascript
const law_1_appendix = {

    // トリガー条件を定義する
    condition:
        (operation == "disable_plugins")
        & ((disable_after_op_plugin_id == 1) | (disable_after_op_plugin_id == 2))
        & (operator != x_addr),

    // 決断の定義
    return_type: no,

    // 優先度の定義
    return_level: 100,

    // サンドボックスの前に操作を拒否する
    is_before_operation: true,
}
```

### 例 2: ベットオン契約／評価調整メカニズム（VAM）契約

***法的規定: 2035年1月1日までに総収入が 1000 ETH 未満であれば、株主 X は総議決権の 75％、配当権の 90％ を握ることができる。***

*プラグインの設計: サンドボックス内で実行した後、以下の条件をチェックする:*

- *タイムスタンプ >= 2035/01/01*

- *2000年1月1日以降の収入 < 1000 ETH*

- *操作は "mint_tokens"*

- *X の総議決権 <= 75%*

- *x の配当力 <= 90%*

*その場合、プラグインはその操作を承認しなければならない*

By-law script では、上記のプラグインを次のように定義できる:

```javascript
const bet_on_2 = {

    // トリガー条件を定義する
    condition:
        (timestamp >= toTimestamp('2035/01/01')) &
        (revenue_since(946706400) < 1000000000000) & // 1000000000000 Gwei = 1000 ETH
        (operation == "mint_tokens") &
        (total_voting_power_percentage(x) < 75) &
        (total_dividend_power_percentage(x) < 90),

    // 決断の定義
    return_type: yes,

    // 優先度の定義
    return_level: 100,

    // サンドボックスで実行後、操作を承認する
    is_before_operation: false,
}
```

### 例 3: 従業員給与計算

***法的規定 3: ロールレベル X の従業員の給与は月 10 ETH でなければならない。***

*プラグインの設計: 操作が "add withdrawable cash" であり、金額が 10 ETH 以下であり、最後の操作が少なくとも 30 日前である場合、この操作は承認され、サンドボックスのチェックをスキップする必要があります*

By-law script では、以下の条件でプラグインを定義することができます（例えば、レベル X = 2 は、30 日あたり 10 ETH を引き出すことができます）:

```javascript
const payroll_law_level_2 = {
    condition:
        (operation == "add_withdrawable_cash") &   // 操作は "add withdrawable cash"
        (member_role_level == 2) &   // オペレータアドレスがロールレベル  2である

        // 現金を加える < 30 日ごとに = 2592000 秒
        (operator_last_operation_window("add_withdrawable_cash") >= 2592000) &
        // 毎回 < 10000000000 Gwei = 10 ETH を口座に追加する
        (add_withdrawable_cash_amount <= 10000000000),

    // 操作を承認し、サンドボックスチェックをスキップする
    return_type: yes_and_skip_sandbox,
    return_level: 1
    is_before_operation: true,
}
```

上記のプラグインを使用すると、オペレータは従業員のアカウントに 10 ETH 以下の金額で引き出し可能な現金を追加することができます。
プラグインは操作を承認し、サンドボックスチェックをスキップします。従業員アドレスが無効化された場合、ロールレベル X から削除された場合、
または優先順位の高い他のプラグインが操作を拒否した場合、これらの操作は拒否されます。

### 例 4: 投票と法案

日常業務では、取締役会をアドレスのグループとして定義し、議決権行使メカニズムを使って意思決定を行うことができる。
例えば、次のようなシナリオで投票メカニズムを設計する:

1. 総議決権の 10％ 以上を持つアドレス X は、全理事会メンバーの 2/3 がその行動を承認した場合に限り、
   1 トークン（レベル 2、理事会投票トークン）を鋳造することで理事会に加えることができる（投票ルール 1）。

```javascript
const add_board_member = {
    condition:
        (operation == "mint_tokens") &   // 操作は "mint_tokens"
        (mint_tokens_level == 2) &  // トークンレベルは 2
        (mint_tokens_amount == 1) &  // 量は 1
        (operator_total_voting_power_percentage >= 10),   // 事業者の住所が総議決権の 10% 以上を保有すること
    return_type: voting_needed,
    voting_rule: 1,  // 議決権行使ルール 1 では、全取締役の 2/3 以上の賛成があった場合にのみ承認される
    return_level: 100,
    is_before_operation: false, // サンドボックスで実行した後に判断する
}
```

2. 全投票数の 7% 以上の投票権を持つ運営者は、`enable_plugins()` を提出することができ、全理事の 100% の承認を得る必要があります。
   各オペレータは 10 日ごとにプラグインの有効化を試みることができる。

```javascript
const enable_plugin = {
    condition:
        (operation == "enable_plugins") &   // 操作は "enable_plugins"
        (operator_total_voting_power_percentage >= 7) &   // 事業者の住所が総議決権の 7％ 以上を保有していること
        (operator_last_operation_window("enable_plugin") >= 864000),  // 各オペレーターは、864000 秒（10 日間）に一度、プラグインを有効にしようとすることができます

    return_type: voting_needed,
    voting_rule: 2,  // 議決権行使ルール 2 では、全理事会メンバーの 100％ が承認した場合にのみ、その事業が承認される
    return_level: 100,
    is_before_operation: false, // サンドボックスで実行した後に判断する
}
```

3. プラグイン 2,3,4 を無効化するためには、運営者が総議決権の 20% 以上を保有し、かつ、相対多数決（議決権行使ルール 2）として
   全普通株式トークン（レベル 0）投票者の 70% の賛成を得る必要がある。DARC の各メンバーについて、この操作は 15 日（1296000 秒）に 1 回実行できる。

```javascript
const disable_2_3_4 = {
    condition:
        (operation == "disable_plugins") &   // 操作は "disable_plugins"
        (
            disable_after_op_plugin_id == 2
            | disable_after_op_plugin_id == 3
            | disable_after_op_plugin_id == 4
        ) &  // プラグイン 2,3,4 を操作後に無効にする
        (operator_total_voting_power_percentage >= 20) &   // 事業者の住所が総議決権の 20% 以上を保有すること
        (operator_last_operation_window("disable_plugins") >= 1296000),  // 各オペレーターは 1296000 秒（15 日間）に一度、プラグインの無効化を試みることができる
    return_type: voting_needed,
    voting_rule: 3,  // 議決権行使ルール 3 では、全普通株式保有者の 70％ が賛成した場合にのみ、本運用が承認される
    is_before_operation: false, // サンドボックスチェック後に決断を下す
}
```

### 例 5: マルチレベルトークン: 製品トークンと非代替性トークン

以下は、議決権と配当権のレベルが異なるトークンの設計方法の例である。議決権および配当権は、各トークンホルダーの議決権および配当権を計算するために使用される。
以下はトークンレベルの表である:

| レベル | トークン                            | 投票権        | 配当力          | 総供給量       |
|-------|------------------------------------|--------------|----------------|--------------|
| 0     | レベル0 普通株式                     | 1            | 1              | 100,000      |
| 1     | レベル1株式                         | 20           | 1              | 10,000       |
| 2     | 取締役会                            | 1            | 0              | 5            |
| 3     | 経営陣                              | 1            | 0              | 5            |
| 4     | 無議決権株式                         | 0            | 1              | 200,000      |
| 5     | プロダクトトークン A (0.01 ETH/token) | 0            | 0              | ∞            |
| 6     | プロダクトトークン B (10 ETH/token)   | 0            | 0              | ∞            |
| 7     | Non-Fungible Token #1              | 0            | 0              | 1            |
| 8     | Non-Fungible Token #2              | 0            | 0              | 1            |
| 9     | Non-Fungible Token #3              | 0            | 0              | 1            |
| 10    | Non-Fungible Token #4              | 0            | 0              | 1            |
| 11    | Non-Fungible Token #5              | 0            | 0              | 1            |
| ...   | ...                                | ...          | ...            | ...          |

サービス料金の支払いや商品の購入には、`pay_cash()` を使って直接支払うか、`pay_to_mint_tokens()` を支払い方法として使い、商品トークン/NFT を受け取ることができる。

以下は、"Product Token A" と "NFT" の価格と総供給量を定義する方法の例である。

```javascript
const product_token_A_price_law = {
    condition:
        (operation == "pay_to_mint_tokens") &   // 操作は "pay_to_mint_tokens"
        (pay_to_mint_tokens_level == 5) &  // トークンレベルは 5
        (pay_to_mint_price_per_token >= 10000000000000000),   // トークン1個あたりの価格 >= 0.01 ETH = 1000000000000 wei

    return_type: yes_and_skip_sandbox,  // 操作を承認し、サンドボックスチェックをスキップする
    return_level: 1,
    is_before_operation: true, // 操作を承認し、サンドボックスチェックをスキップする
}

const NFT_price_law = {
    condition:
        (operation == "pay_to_mint_tokens") &   // 操作は "pay_to_mint_tokens"
        (pay_to_mint_tokens_level >= 7) &  // トークンレベルが 7 以上
        (pay_to_mint_token_amount == 1) &  // 一度に 1 トークンしかミントできない
        (pay_to_mint_current_level_total_supply == 0) &  // 現在の総供給量は 0
        (pay_to_mint_price_per_token >= 10000000000000000000),   // トークン 1 個あたりの価格 >= 10 ETH = 1000000000000000 wei

    return_type: yes_and_skip_sandbox,  // 操作を承認し、サンドボックスチェックをスキップする
    return_level: 1,
    is_before_operation: true, // 操作を承認し、サンドボックスチェックをスキップする
}
```

### 例 6: 配当利回りを 5 年間固定

配当メカニズムは、一定のルールの下でトークン保有者に配当を分配するように設計されている:

1. 各 `X` の購入取引について、総収入の Y‱ を配当可能な現金とする
2. `offer_dividend()` オペレーションを呼び出すことで、配当可能な現金をトークン保有者の配当引き出し残高に分配することができる
3. トークン保有者一人当たりの配当額（X）は、以下の式で計算される: `dividend_X = dividendable_cash * dividend_power(X) / total_dividend_power`
4. `offer_dividend()` が呼ばれた後、配当可能な現金と配当可能な取引のカウンタは 0 になり、各トークンホルダーの配当引き出し残高は `dividend_X` だけ増加する

配当利回りが安定していることを確認するために、DARC にプラグインを追加し、`set_parameters()` 関数を制限することで、配当利回りを 5 年間固定することができます

***法的規定 6: 配当利回りは2030年1月1日までに 500‱（5％）以上に固定される必要がある。***

```javascript
const dividend_yield_rate_law = {
    condition:
        (operation == "set_parameters") &  // 操作は "set_parameters"
        (set_parameters_key == "dividendPermyriadPerTransaction") &  // キーは "dividend_yield_rate"
        (set_parameters_value < 500) &  // 値が< 500‱ (5%)
        (timestamp < 1893477600),  // タイムスタンプ < unix タイムスタンプ 2030-01-01 00:00:00 (UTC)

    return_type: no,  // 操作を拒否する
    return_level: 1,
    is_before_operation: true, // 操作を拒否し、サンドボックスチェックをスキップする
}
```

### 例 7: 投資プログラムパッケージ

以下は、VC による一般的な投資契約である **Simple agreement for future equity (SAFE)** の非公式なプログラム例である:

1. VC は 1000 ETH（10000000000 Gwei）の現金を投資として DARC に支払う
2. VC は、100,000,000 レベル 0 トークン（普通株式）と 1 レベル 2 トークン（取締役会）を付与される
3. VC は、プラグイン 5、6、7 を無効にする権利を有する
4. VC には、プラグイン 8、9、10、11 を有効にする権利が与えられる
5. VC には、その役割をレベル 5（大株主レベル）に変更する権利が与えられる
6. 契約を記録するために PDF 文書に署名してスキャンし、PDF 文書を IPFS にアップロードし、IPFS ハッシュ `QmcpxHN3a5HYnPurtuDs3jDfDSg1LPDe2KVBUG4RifcSbC`
   を DARC パーマネントストレージ配列に追加することを推奨する。
   これは、必要に応じて緊急エージェントが DARC の技術的問題を検証し、修正するのに役立つ。

```javascript
const vc_addr = "0x1234567890123456789012345678901234567890";  // 自分のアドレスを定義する

pay_cash(1000000000000, 0, 1);  // 1000 ETH = 1000000000000 Gwei cash を支払う

mint_token([vc_addr], [100000000], [0]);  // 100,000,000 レベル 0 トークン（普通株）を VC ファームにミントする

mint_token([vc_addr], [1], [2]);  // 2 レベルのトークン（役員会）を 1 つ VC ファームにミントする

disable_plugins([5, 6, 7], [false, false, false]) // 操作後のプラグイン 5、6、7 を無効にする

enable_plugins([8, 9, 10, 11], [false, false, false, false]) // このプログラム以前に追加されたプラグイン 8、9、10 を有効にする

change_member_role(vc_addr, 5);  // VC の役割をレベル 5（大株主レベル）に変更する

/** 最後に、DARC が DARC を引き継ぐために緊急エージェントを必要とする場合に備え、
 * SAFE 文書に署名し、スキャンし、IPFS にアップロードし、ピンを立て、
 * IPFS のハッシュ値を DARC に追加する
 */
add_storage(['QmcpxHN3a5HYnPurtuDs3jDfDSg1LPDe2KVBUG4RifcSbC']);
```

## ソースのビルド

Hardhat と OpenZeppelin を使用しているので、プロジェクトは以下のコマンドでビルドできます:

1. 依存関係のインストール

   `npm` の代わりに `pnpm` を使うことを推奨しますが、`npm` でも動作します。

   `pnpm` は新しいパッケージマネージャーで、npm よりも優れている点がいくつかある。より速く、より効率的で、ディスクスペースに優しいです。

    ```shell
    cd darc-protocol
    npm install
    ```

2. コントラクトのコンパイル

    ```shell
    npx hardhat compile
    ```

3. Darc テストネットワークの実行

    ```shell
    npm run node
    ```

4. コントラクトのテスト

    ```shell
    npx hardhat test
    REPORT_GAS=true npm run test
    ```

5. コントラクトのデプロイ

    ```shell
    npm run deploy
    ```
