Unity Flipbook Motion Blending
===

このリポジトリには、Unity用のFlipbook Motion Blendingシェーダーが含まれています。

これは、モーションベクターエクスポート機能がないツールでレンダリングされたFlipbookフレームからモーションベクターを生成する、私の新しいツールをテストするために使用しています。

これは初期プロトタイプであり、参照実装として使用できます。しかし、シェーダーにはShurikenカスタム頂点ストリームのサポートなど、さまざまな機能が欠けています。

モーションベクターテクスチャはHoudiniまたは私の新しいツールを使用して生成できます。

## Motion Strengthの計算

Motion Strengthの値は、モーションベクターテクスチャの生成方法によって異なります。一部のツール（私の開発中のツールを含む）では、エクスポート時にこの値が表示されるため、その場合はその値をマテリアルにコピーアンドペーストするだけです。

ツールのベクトル出力がフレームレート（FPS）に依存している場合、パラメータはFPSの逆数として計算できます。

$$ \text{Motion Strength} = \frac{1}{\text{Frame Rate}} $$

例えば、レンダー設定が24fpsの場合、Motion Strengthは0.041667になります。

Labs Flipbook Texturesレンダーノードはこのアプローチを使用しますが、Max Speed Allowed値がMotion Strengthに影響する可能性があるため、速い動きのアニメーションを扱う場合は値を調整する必要があるかもしれません。

ツールでDisplacement Strengthを設定できる場合、パラメータはフレーム解像度で割ることによって計算できます。

$$ \text{Motion Strength} = \frac{\text{Displacement Strength}}{\text{Frame Resolution}} $$

例えば、Displacement Strengthを10に設定し、フレーム解像度が128x128の場合、Motion Strengthは0.078125になります。
