
# Practice of BGP and OSPF

とある理由のネットワークのお勉強

## 構築手順

- quaggaという名前のLXDベースイメージを作成
- setup.shを実行
- test1.shを実行
- 妥協: r2,r3,r5に入って地道にquaggaをコンフィグ
	- 目標: r0-r6に入って地道にquaggaをコンフィグ
- test2.shを実行
- test3.shを実行

## 撤収手順

- shutdown.shを実行

## 各シェルスクリプトの説明

- test1.sh: 全リンクのそれぞれの到達性を確認
- test2.sh: BGPのリーチャビリティーの確認
- test3.sh: client to serverのリーチャビリティーの確認

## References

- https://github.com/vishvananda/netns
- https://github.com/redhat-nfvpe/koko
- http://wiki.slankdev.net/misc/lxd
- http://wiki.slankdev.net/misc/quagga

構築する仮想NWのtopo図

![](./topo.png)

