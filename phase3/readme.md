
# Practice of BGP and OSPF

とある理由ネットワークのお勉強

## 構築手順

- setup.shを実行
- 確認1を実行
- 各コンテナに入って地道にquaggaをコンフィグ
- 確認2を実行

## 確認1: オペレータテスト: IP neighbor reachability

以下を実行. 全てのリンクの到達性を確認する.

```
host$ lxc exec c0
```

## 確認2: オペレータテスト: BGP reachability

## 確認3: クライアントテスト

現状はなし

## 撤収手順

- shutdown.shを実行


