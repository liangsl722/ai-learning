
<map>
  <node ID="root" TEXT="Reinforcement Learning">
    <node TEXT="" ID="863db2200e26bfc34f1e92b52326cf4c" STYLE="bubble" POSITION="right"/>
    <node TEXT="Basic Conceptions" ID="61119d794bde2bf4f9984367427a5045" STYLE="bubble" POSITION="right">
      <node TEXT="State" ID="920d270ff85c3d29b15d73d0ca90dde9" STYLE="fork">
        <node TEXT="状态 Si" ID="b68cba68b29043cb31ee7805141fa45b" STYLE="fork"/>
        <node TEXT="状态空间 S" ID="4976ce437cee0e58f6467a79423d8d5b" STYLE="fork"/>
      </node>
      <node TEXT="Action" ID="cb03582a9ee19a30ed43cb22502182da" STYLE="fork">
        <node TEXT="每个状态有若干可能动作 ai" ID="2a1f534178f1b631ac4a8607655e9c77" STYLE="fork"/>
        <node TEXT="某个状态的动作空间 A(si)" ID="9f1406e747674209e589c733332e6047" STYLE="fork"/>
      </node>
      <node TEXT="State transition" ID="1b5b57ad8494896661747cc99cda2e07" STYLE="fork">
        <node TEXT="执行动作后，从一个状态转移到另一个状态的过程" ID="8abd5c2b85410a65236660692b3b5406" STYLE="fork"/>
        <node TEXT="Forbidden area" ID="6e614875aebacc4aa83f8f596930a019" STYLE="fork">
          <node TEXT="可以进入但是会被惩罚" ID="8ff8f5603b2a998a8dad7522823007b0" STYLE="fork"/>
          <node TEXT="不能进入（比如物理上有一堵墙）" ID="91a493399f656ee4cb77a9349aa47ece" STYLE="fork"/>
        </node>
        <node TEXT="State transition probability" ID="82319028801737d49a4fe4299368a34b" STYLE="fork"/>
      </node>
      <node TEXT="Policy" ID="66a4130d4f39e1564d8454e0e43e71da" STYLE="fork">
        <node TEXT="告诉agent在该状态执行什么动作" ID="4ccee6cf4324ce8c6eed55efa5f0ed1a" STYLE="fork"/>
        <node TEXT="Π(ai | s1) 在状态s1执行某个 action 的条件概率" ID="4f71ac5046b8ec41c1778776f284d84a" STYLE="fork"/>
        <node TEXT="确定性 deterministic 和不确定性 stochastic" ID="3e4fc8da0caa322899d84453abbd6ee6" STYLE="fork"/>
      </node>
      <node TEXT="Reward" ID="47d125d8d932bebd8ffaf6a8ae4009a0" STYLE="fork">
        <node TEXT="实数。在执行一个 action 后获得的" ID="50af65d5e847c0867df59b5b58e4d767" STYLE="fork"/>
        <node TEXT="positive → encouragement" ID="349e5880548f38a03392f9c1bf4d9420" STYLE="fork"/>
        <node TEXT="negative → punishment" ID="44f7a197ea0a1fb9a34c7d0aa4625ec9" STYLE="fork"/>
        <node TEXT="0 → 实际上是一种鼓励" ID="72e4d8cd35693766e85324d523a6b16d" STYLE="fork"/>
        <node TEXT="P(r = -1 | s1, a1) 在状态s1执行a1后得到reward=-1的概率" ID="aeddcf5fa07a7360983ca9a9448b01df" STYLE="fork"/>
        <node TEXT="reward依赖于state和action，而不依赖于下一个状态" ID="dda619eeb9cc1cd41265d3784f2a4c1b" STYLE="fork"/>
      </node>
      <node TEXT="Trajectory" ID="17e93401215b76e5a14611b50048d701" STYLE="fork">
        <node TEXT="a state-action-reward chain" ID="ef1e3d7b474d6401f73182d63c77e803" STYLE="fork"/>
      </node>
      <node TEXT="Return" ID="2f22f3d3f6a1bf14dd034c63af02d2e5" STYLE="fork">
        <node TEXT="沿着一条 trajectory 得到的所有 reward 之和" ID="f4de1671003389f4519dfe9fc56628a3" STYLE="fork"/>
        <node TEXT="比较 return 来评估 policy 的好坏" ID="16641d60dd3b2881594f4f0a139ca35f" STYLE="fork"/>
      </node>
      <node TEXT="discount rate" ID="4f068a8929c569e7dd6846e4f43fc150" STYLE="fork">
        <node TEXT="γ ∈ [0,1)" ID="310dec97b77bb69d57087f7380119346" STYLE="fork"/>
        <node TEXT="discounted return = r0 + γ*r1 + γ^2*r2 + ..." ID="4cc3feb07e674b0bf99bdaeda2dfa607" STYLE="fork"/>
        <node TEXT="γ 越小，越看重当前" ID="c39007da2553b0bb35f424a444d9679e" STYLE="fork"/>
        <node TEXT="γ 越大，越看重未来" ID="e36c1cac3b18c6c1d173805a958d7abf" STYLE="fork"/>
      </node>
      <node TEXT="Episode" ID="092c44c53d4a6dc81d8bcaeea11e1b68" STYLE="fork">
        <node TEXT="能够到达 terminal states 的 trajectory，也称为一个 trial" ID="d365e2f72aa2b513f06fd6e36d9110a8" STYLE="fork"/>
        <node TEXT="episode是有限步的trajectory" ID="5c8853985359e7fc647ffe8d8bebec6a" STYLE="fork"/>
        <node TEXT="episodic tasks VS continuing tasks：可以不加区分，进行转化" ID="045c067a0e1ecc11fc870a911cec9395" STYLE="fork">
          <node TEXT="1. 把target state认为是一个absorbing state，一旦agent到达了absorbing state，就永远不会离开。接下来的rewards=0" ID="a180e7ee1eadda19ba787d309d2dea3c" STYLE="fork"/>
          <node TEXT="2. 认为target state是一个普通的state。agent仍可以离开target state然后再次进入时获得 r=+1" ID="a607d1a53b3233579b3af42991e07a46" STYLE="fork"/>
        </node>
      </node>
    </node>
    <node TEXT="Markov decision process (MDP)" ID="5e6efb1211f09e7a6a8d17ac2057a0da" STYLE="bubble" POSITION="right">
      <node TEXT="Sets:" ID="fe4858872ac75e31cfa714861c2350a0" STYLE="fork">
        <node TEXT="State: S" ID="8da3db43a1d6bde79575df0ba2a8841a" STYLE="fork"/>
        <node TEXT="Action: A(s)" ID="bdfaabfb0bd6aec378e40be9aff1ded6" STYLE="fork"/>
        <node TEXT="Reward: R(s, a)" ID="5334cb838a52bfab8a5e4968e7e63c02" STYLE="fork"/>
      </node>
      <node TEXT="Probability distribution:" ID="30e14e23e532f2dd719fcc9063c5fa17" STYLE="fork">
        <node TEXT="State transition probability: p( s&apos; | s, a)" ID="c74d749451a708062364a7103a144729" STYLE="fork"/>
        <node TEXT="Reward probability: p( r | s, a)" ID="8f43542d61e85ca74f0bfd66c6827ac1" STYLE="fork"/>
      </node>
      <node TEXT="Policy:" ID="8654e25b188862bc5f4045bb4615b8e7" STYLE="fork">
        <node TEXT="Π( a | s)" ID="f1dac0775ff09308d69f014004bdc022" STYLE="fork"/>
      </node>
      <node TEXT="Markov property: memoryless property 与历史无关，只和当前状态有关" ID="3d61aec061b99a8bc7dd957eb511150b" STYLE="fork"/>
    </node>
    <node TEXT="Bellman Equation" ID="b10f3295221693c3c7c643caa8a57dc4" STYLE="bubble" POSITION="right">
      <node TEXT="Return" ID="af3408a81cab96b213305ba96436ccdf" STYLE="fork">
        <node TEXT="vi 表示从 si 出发得到的 return" ID="1e8e94368f4c6eaa28e1e968835df15f" STYLE="fork"/>
        <node TEXT="returns 依赖于从其他状态出发所得到的return （Bootstrapping）" ID="d02b55e8aa562837ac6bef188a4b86ed" STYLE="fork"/>
        <node TEXT="矩阵形式" ID="21987a4b69bf874727b0131d2e72e8f6" STYLE="fork">
          <node TEXT="the value of one state relies on the values of other states" ID="58f419ebfac65919b49a1dee4e2341af" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="State value" ID="ee282ae55a34309c75cb7f101382ba30" STYLE="fork">
        <node TEXT="notations" ID="fb5778ed5945c8c84cd8ed5e8336f453" STYLE="fork"/>
        <node TEXT="State value" ID="05c177c723f1242ed5b18a74f298e914" STYLE="fork">
          <node TEXT="definition：" ID="45cb31d94846216da9ff43b0ba4efc42" STYLE="fork"/>
          <node TEXT="s的函数，状态从s出发的一个条件期望" ID="e59aad3bf810ccd12dc5e13bc6438587" STYLE="fork"/>
          <node TEXT="基于policy Π，不同的policy，对应不同的state value" ID="9a0722d1ffbf3ad4c70b05f325879345" STYLE="fork"/>
          <node TEXT="state value越大，policy越有价值，因为从这个state出发可以得到更大的rewards" ID="c5d9d9a30b5440df25a4a2586c0c22ce" STYLE="fork"/>
          <node TEXT="return是针对单个trajectory；state value是对从一个state出发产生的所有的trajectory得到的return求平均" ID="52154f78504366c31e8e04252e7ba087" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="Bellman equation: Derivation" ID="f01bbf08ba98478a73782d46a8fe54ea" STYLE="fork">
        <node TEXT="描述了不同状态的 state value 之间的关系" ID="56507ec8580ecd81968e476c2df22dbd" STYLE="fork">
          <node TEXT="1. mean of immediate rewards" ID="f8f4f280bb0e8498fad8fe226cb6d419" STYLE="fork"/>
          <node TEXT="2. mean of future rewards" ID="666da2b6f2603fa70576b027d7e5e98f" STYLE="fork"/>
          <node TEXT="therefore: " ID="e7a5aa65d1a7fb64d8c74f39b3357bf9" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="Bellman equation: Matrix-vector form" ID="076791d96578603b39bc629322e7df00" STYLE="fork">
        <node TEXT="" ID="5abb9b65b44047fd6182cb464302c445" STYLE="fork"/>
      </node>
      <node TEXT="Bellman equation: Solve the state values" ID="acec1fa25753a1c94688b1b04cb83584" STYLE="fork">
        <node TEXT="policy evaluation" ID="4b3ec256827bbf2194d26cca9d584939" STYLE="fork">
          <node TEXT="给定一个 policy，列出bellman公式，求解得到state value的过程" ID="3f6b12e1a10e0f28246ab2515c94bab3" STYLE="fork"/>
        </node>
        <node TEXT="closed-form solution:" ID="6731f14f577b5f119862ec195b9ecb64" STYLE="fork">
          <node TEXT="解析解表达式如下，但需要求逆" ID="4d3d7ea48c785ebbcbbc767891f82e53" STYLE="fork"/>
        </node>
        <node TEXT="iterative solution:" ID="c5b00bde1903a21152c5b2a49d061aab" STYLE="fork">
          <node TEXT="迭代可证明k趋近∞时，vk收敛到vΠ" ID="3a398b3b8eb01be07b1566a21610b867" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="Action value" ID="f489996313a7eaa554d34655efecfd2a" STYLE="fork">
        <node TEXT="state value 是agent从一个state出发可以得到的平均return；" ID="44f93b7fee3b8fa7f7cd85b76a09c1c9" STYLE="fork"/>
        <node TEXT="action value 是agent从一个state出发选择一个action可以得到的平均return" ID="a87a65261fc655b06ce1a1dde48ff24d" STYLE="fork"/>
        <node TEXT="definition：" ID="b643a97e7d1b62dc19dd2617a5313f95" STYLE="fork"/>
        <node TEXT="是 state-action pari (s, a) 的函数，依赖于policy Π" ID="e4f3044a5f4c9b16e39b83bb6c53c877" STYLE="fork"/>
        <node TEXT="action-value function：" ID="243422a8578a39b3315eb0fbe5316393" STYLE="fork"/>
        <node TEXT="计算 action value：" ID="1faacdfbe21013b3116b3005a09d229f" STYLE="fork">
          <node TEXT="根据state value求出；" ID="9491bb69a9c8d4c5e8bcd6a839d02b71" STYLE="fork"/>
          <node TEXT="直接计算action value，with or without models" ID="fbe3511159e21ce30209f279fd01e420" STYLE="fork"/>
        </node>
      </node>
    </node>
    <node TEXT="Bellman Optimality Equation" ID="3be2411cd7b2a0221eda3c0f7ecedb06" STYLE="bubble" POSITION="right">
      <node TEXT="Optimal policy:" ID="86c0aa9db35632fd0f2ca35678d9be83" STYLE="fork"/>
      <node TEXT="贝尔曼最优公式:" ID="f4391de9a1d640354b8e565f34f3ec2c" STYLE="fork">
        <node TEXT="BOE (elementwise form):" ID="6a1ee4977ffcdc99db3d78fa6c393f8c" STYLE="fork"/>
        <node TEXT="BOE (matrix-vector form):" ID="73954764566cbcd9ccbafc633ccf4099" STYLE="fork"/>
        <node TEXT="假设当 a=a* 时，q(s, a) 取最大。那么，当 a=a* 时，令 Π(a | s) = 1；当 a≠a* 时，令 Π(a | s) = 0，即可以得到最大的 v(s)." ID="f4e1c2298b57d802dbc854dc8e0dd36a" STYLE="fork"/>
        <node TEXT="在矩阵形式中，要求解的BOE就变成了 v = f(v)" ID="b1ce3b7f16612d5b6677bcd3c5525e1f" STYLE="fork"/>
      </node>
      <node TEXT="Contraction mapping theorem" ID="c1bc09344f3bbfbe4cfdb5df3ab7f046" STYLE="fork">
        <node TEXT="Fixed point: " ID="16254e816a5927512f19ef33f2b10342" STYLE="fork"/>
        <node TEXT="Contraction mapping:" ID="c72996610443c5990f588fdc75f39d67" STYLE="fork"/>
        <node TEXT="定理：" ID="10b575adc6e0dd8ad7cf3cd22daffeae" STYLE="fork"/>
      </node>
      <node TEXT="求解贝尔曼最优公式：" ID="821953975a35213daff886aa9e0512e2" STYLE="fork">
        <node TEXT="BOE v=f(v)是一个contraction mapping，故：" ID="ec1e4376f7b6e840c0097b973ca2afa7" STYLE="fork">
          <node TEXT="存在解v*" ID="066a51aa447f63fd5e393ec97fcde3a1" STYLE="fork"/>
          <node TEXT="并且是唯一解" ID="cd8c76bafa389877d2b8ad909c79c5c7" STYLE="fork"/>
          <node TEXT="可以通过 v_k+1 = f(v_k) 的迭代算法求解，最终收敛到v*" ID="57daf134b30c97b76865dfcd18e40cfd" STYLE="fork"/>
        </node>
      </node>
    </node>
    <node TEXT="Value Iteration and Policy Iteration" ID="dedee09effbbf28f17cfc4999fcdcf99" STYLE="bubble" POSITION="right">
      <node TEXT="Value Iteration Algorithm" ID="2ccb45d7b81e8dcd442c7a7bc373d452" STYLE="fork">
        <node TEXT="更新policy时，总是会选取对应qk最大的action，使其概率=1，而其他所有action概率都为0" ID="18fafbc0e0a0cc49aa4bc1366a104373" STYLE="fork"/>
      </node>
      <node TEXT="Policy Iteration Algorithm" ID="bf2146211c550893a863015051a323e1" STYLE="fork">
        <node TEXT="接近目标状态的策略会先变好。在某个状态选择greedy action时（action对应最大的action value）严重依赖于其他状态的策略，当这个状态周围没有状态能到达目标区域的时候，它也无法到达目标区域" ID="d98cc7c744d0ba9bf542e75c4317168c" STYLE="fork"/>
      </node>
      <node TEXT="Truncated Policy Iteration Algorithm" ID="7489167876994189960070fcc6f1cff6" STYLE="fork">
        <node TEXT="比较 policy iteration 和 value iteration" ID="1422c7063e891e3dd8649f289ed15de5" STYLE="fork"/>
        <node TEXT="j=1时，truncated就是value iteration；j=∞时，truncated就是policy iteration" ID="c9ac9b81085a688d88aaea0e80a7fce9" STYLE="fork"/>
      </node>
    </node>
    <node TEXT="Monte Carlo Learning" ID="862f34143415beff546a23932d28c034" STYLE="bubble" POSITION="right">
      <node TEXT="model free" ID="313a55b3a81547ab4b81c4792d459054" STYLE="fork"/>
      <node TEXT="依据大数定理，样本均值收敛于期望，进行数值求解" ID="1fd60880c6055057e347db7a172adc8f" STYLE="fork"/>
      <node TEXT="MC Basic" ID="01f90392a0df8974b009ac22ef24c8d4" STYLE="fork">
        <node TEXT="将policy iteration转化成model-free" ID="01ea0c874b78a513032c119b115b2b48" STYLE="fork"/>
      </node>
      <node TEXT="MC Exploring Starts" ID="c9b9931adc02300431c4dcac8c47b52b" STYLE="fork">
        <node TEXT="从后往前（T-1, T-2, ..., 0）计算return" ID="a6768abab0bf864d9791061e0d3cf33a" STYLE="fork">
          <node TEXT="exploring：从每一个(s, a)出发，都要有episode，这样才能保证可以用后面生成的reward来估计return，进一步估计action value。如果有一个action没有被访问到，就可能因此遗漏最优" ID="c7e2ddd4e497b255408d7dbf536543a5" STYLE="fork"/>
          <node TEXT="starts：从(s, a)开始一个episode。不采用从其他(s, a)开始一个经过当前(s, a)的episode（称为visit），因为visit没办法确保exploring" ID="c67b5bfd5e6675948a09d9d7a45b2f8c" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="MC ε-Greedy" ID="b0acd404d3c0f199660712dd84e32807" STYLE="fork">
        <node TEXT="soft policies：有可能选择每一个action" ID="f0662ec81fb72c56c937772d3677946a" STYLE="fork"/>
        <node TEXT="使q_Π(s,a)取得最大的greedy action以大概率，而其他action均分剩余小概率" ID="6ea850779b211dc044071f52108bc2ac" STYLE="fork"/>
      </node>
    </node>
    <node TEXT="Stochastic Approximation &amp; Stochastic Grandient Descent" ID="c401857fb332950037e57e16c9351ebd" STYLE="bubble" POSITION="right">
      <node TEXT="Stochastic approximation (SA)" ID="58995854101624ce76962edb485b2646" STYLE="fork">
        <node TEXT="随机近似SA代表了随机 stochastic 迭代 iterative 算法的大类，进行方程求解或者优化问题" ID="1f4060ca40f11d082c0d5553550f082e" STYLE="fork"/>
        <node TEXT="不需要知道方程或者目标函数的表达式" ID="afb522e24a024f77a11dfb266f6200d1" STYLE="fork"/>
      </node>
      <node TEXT="Robbins-Monro algorithm (RM)" ID="d61bb3409c5f868c1adeae8545d31656" STYLE="fork">
        <node TEXT="RM属于SA领域，随机梯度下降stochastic gradient descent是RM算法的一个特例" ID="5cb46c60c36b7feb4b78d3fb1a0f885f" STYLE="fork"/>
        <node TEXT="问题：求解 g(w) = 0，且函数表达式 g 未知" ID="78e030b58b6f3e1b2cbc3d6107b0d2ca" STYLE="fork"/>
        <node TEXT="定理：" ID="cd2fb35f879d1bfcf4514aa1941ec3ed" STYLE="fork">
          <node TEXT="1). 梯度：g 是单调递增的，保证g(w) = 0 存在且唯一；并且是有界的，不会趋向于无穷而发散" ID="450b55d19761005cebab1a1a1ca6bae3" STYLE="fork"/>
          <node TEXT="​2). 系数a_k ：平方和小于∞，确保a_k收敛到0；和等于∞，确保a_k收敛速度不要太快" ID="9ccaa4232e6e9b5142613abfe9984d21" STYLE="fork">
            <node TEXT="实际上，如果令a_k=1/k，后面进来的数据由于a_k趋向于0而起到的作用很小，由于实际上会希望这些数据仍然有用，所以会选择将一个很小的常数赋值给a_k" ID="ac0937000890fdc964c1fd2319f0b3cd" STYLE="fork"/>
          </node>
          <node TEXT="3). 测量误差η_k：mean是0，variance有界" ID="edceae7f7b5c53c530f796c9a09e40e3" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="Stochastic gradient descent (SGD)" ID="b53da0ee68720bd2eb86e81b88c56b4c" STYLE="fork">
        <node TEXT="问题：优化问题，求解 min_w J(w) = E[f(w,X)]. 其中w是被优化的参数，X是随机变量" ID="bffb8cff7a0dc7d8e5ba8eca1f0985c8" STYLE="fork"/>
        <node TEXT="Method 1：gradient descent (GD)" ID="5fd1b9527348326ce54c47f42afd4d6e" STYLE="fork">
          <node TEXT="沿梯度方向下降进行优化。α_k是步长，控制在梯度方向下降的速度" ID="81668db0fd94c8f6f5827a5d2d540c26" STYLE="fork"/>
          <node TEXT="期望值难以获得" ID="e1642e1483b7ae0e8d8a5155fcf9d68b" STYLE="fork"/>
        </node>
        <node TEXT="Method 2：batch gradient descent (BGD)" ID="356924fcf3549e02a5a9d48026f08382" STYLE="fork">
          <node TEXT="MC的基本思想，对目标多次采样的平均值估计期望" ID="b89651d9cc32e8f626f553c0d26e7978" STYLE="fork"/>
          <node TEXT="每次更新w_k时需要采样很多次" ID="244e9c41b5b17e1c43043e1186507e4b" STYLE="fork"/>
        </node>
        <node TEXT="Method 3：stochastic gradient descent (SGD)" ID="7dfe8d5d41614da4887321bb6bd7623c" STYLE="fork">
          <node TEXT="与GD相比，GD用的真实梯度期望true gradient，而SGD中用的x_k的随机梯度stochastic gradient" ID="e089ddd74d311d260186f198866a6743" STYLE="fork"/>
          <node TEXT="与BGD相比，将BGD中的n设置为1，就是SGD" ID="8f8873325934aa65d9f522050df618fd" STYLE="fork"/>
          <node TEXT="SGD是一个特殊的RM算法。" ID="c13e5b6e17a74b23609e0d766fe49dfe" STYLE="fork">
            <node TEXT="最小化 J(w) = E[f(w,X)] &lt;==&gt; g(x) = ▽_w J(w) = E[▽_w f(w,X)] = 0" ID="632862a91d093295dbade97bd6ee1c69" STYLE="fork"/>
          </node>
          <node TEXT="当w_k离w*较远时，相对误差较小，SGD表现近似于GD；当w_k靠近w*时，相对误差变大，在w*周围变现出更强的随机性" ID="9a3b0a4ea021bd059ef6a6ea99350faf" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="比较BGD, MBGD, SGD" ID="506f6caff0a202abf8b402ab04490316" STYLE="fork">
        <node TEXT="BGD每次用所有的采样求平均，最接近于真实期望；mini-batch每次只使用部分采样；SGD每次随机采样一个" ID="1de07a324226ff0f5abe2c389886c1f6" STYLE="fork"/>
      </node>
    </node>
    <node TEXT="Temporal-Difference Learning" ID="41af368cb85ad9a3c6e1db4c40866c7a" STYLE="bubble" POSITION="right">
      <node TEXT="TD算法" ID="acd70227265f1f7bd7b3defa983fa1d1" STYLE="fork">
        <node TEXT="此时的TD算法是特指用于估计state values的算法" ID="7e8d55dcd077717f712476cbe6ba48ca" STYLE="fork"/>
        <node TEXT="基于数据 data/experience" ID="d5b90f927f986f43453f5552197bbf66" STYLE="fork"/>
        <node TEXT="TD learning algorithm:" ID="473f417223de7cc01217037dc8af1ed7" STYLE="fork">
          <node TEXT="对于(2)式，如果现在访问到的状态是s_t，那么其他状态的value是不更新的" ID="af1b7a03d5dcd68a36708d7e394cc37d" STYLE="fork"/>
          <node TEXT="对于(1)式：" ID="91e9277fb184e3eff7afcc621b4852b2" STYLE="fork">
            <node TEXT="TD target：算法将v(s_t)朝着v_t-bar的方向改进" ID="7de1d1ee69b816e62f9db9086aefbdd7" STYLE="fork"/>
            <node TEXT="TD error：描述了两个时间步之间的差距；反映了v_t 和 v_Π 之间的差距" ID="99a2fcc080fff7c59a5d6343648dde6e" STYLE="fork"/>
          </node>
          <node TEXT="mathematically：给定策略 Π ，求解Bellman公式（在没有模型的情况下）" ID="d373a2e8d072523b29bdca238a36983e" STYLE="fork">
            <node TEXT="Bellman expectation equation：" ID="6a92a96bc50cdfadd82cc3fec2ef9ede" STYLE="fork"/>
            <node TEXT="将{(s, r, s&apos;)}变成了序列{(s_t, r_t+1, s_t+1)}，并不是从s出发得到r、s&apos;，而是得到一个trajectory，如果这个trajectory恰巧访问到了s就去更新一下s，如果没有访问到s那么s所对应的估计值保持不动。由此通过一个trajectory实现对所有的s进行更新" ID="b4809dd53d0995780ec46840ff7c81c6" STYLE="fork"/>
            <node TEXT="将v_Π(s&apos;)替换成v_k(s&apos;_k)，直接用s’在第k步的估计值代替真实值，虽然存在偏差，但是最终会收敛到v_Π" ID="3afdab167acb9ce12fc9880910a5104a" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="比较TD和MC" ID="17a0fbf89df83be7790d1b977eee816a" STYLE="fork"/>
      </node>
      <node TEXT="Sarsa：TD learning of action values" ID="824f6cfadad2c5e84c754ff7a5663171" STYLE="fork">
        <node TEXT="目标：估计给定策略Π的action values。是之前TD算法中估计 v(s) 改成了估计 q(s, a)" ID="0fa448339efa231cc44777f3b4123640" STYLE="fork"/>
      </node>
      <node TEXT="Expected Sarsa:" ID="5f04cb598863eb899fc5d51e4b618012" STYLE="fork">
        <node TEXT="TD target 变了" ID="944c75e744abc0241b1b6e3b56db0a28" STYLE="fork"/>
        <node TEXT="计算量更大。从a_t+1变成了A，涉及到的随机变量个数减少，随机性也相对减少" ID="832ae148fcc54162125bbd2ac2b0149f" STYLE="fork"/>
      </node>
      <node TEXT="n-step Sarsa:" ID="1a70e0f8499fdd535db95b0d6ce7dd7c" STYLE="fork">
        <node TEXT="结合了Sarsa和Monte Carlo learning" ID="2a90c952f4303ad22e6b1d78ccafcd6e" STYLE="fork"/>
      </node>
      <node TEXT="Q-learning: TD learning of optimal action values" ID="06bc5122f8e64a77b5feb523ca84e503" STYLE="fork">
        <node TEXT="TD target变了，求解一个BOE" ID="3ec2f095df41ca2a6870065a1d484753" STYLE="fork"/>
        <node TEXT="off-policy vs on-policy" ID="bbb0ca0ce6f87faa59bbefc4cd1d274e" STYLE="fork">
          <node TEXT="behavior policy是和环境进行交互，生成experience" ID="5076fc7c66d11df1aeecff62260b44da" STYLE="fork"/>
          <node TEXT="target policy是将target policy不断地更新成optimal policy" ID="a33f3b3d77b8a575ce2591aa8f891295" STYLE="fork"/>
          <node TEXT="on-policy：behavior policy和target policy相同。用策略与环境交互，得到experience，同时改进这个策略，再用这个策略和环境交互..." ID="1c54b2f20775ee85dc8ec0f26b90937e" STYLE="fork"/>
          <node TEXT="off-policy：behavior policy和target policy不同。用一个策略和环境交互得到大量地experience，然后用这些经验不断改进策略，最后收敛到一个最优策略" ID="5bd5d5a27fb7a6a0190131f9b1213229" STYLE="fork"/>
        </node>
        <node TEXT="Q-learning是off-policy，on-policy的Q-learning是off-policy的一种特殊情况" ID="19243a111ff65e8140c893d9e266fba9" STYLE="fork"/>
        <node TEXT="off-policy的Q-learning，应该使用探索性较强的策略作为behavior policy，即Π_b中ε不能太小" ID="5160153bce6378f9d1d3765b22666417" STYLE="fork"/>
      </node>
      <node TEXT="总结" ID="344cc57b33567c1ff35cb78a2d120a27" STYLE="fork"/>
    </node>
    <node TEXT="Value Function Approximation" ID="35aaa4d0510e5697167b93ebbec05638" STYLE="bubble" POSITION="right">
      <node TEXT="优点：" ID="d6b7f8b86517ebd7c1928d35c6d5d453" STYLE="fork">
        <node TEXT="便于存储。只需要存储参数向量w，不用像表格存储大量数据；" ID="aca2e15315fc60b3dde3e17b7ba7d38b" STYLE="fork"/>
        <node TEXT="泛化能力更强。假设s2进行了更改，在表格存储中只会更改s2对应的值，对于其他没有访问到的状态不会修改，而使用value function approximation则会改变w的值，整个拟合曲线都会变化，从而影响其他状态的值，增强了泛化能力" ID="eedbc88c99ee2289178716045386a592" STYLE="fork"/>
      </node>
      <node TEXT="objective function" ID="cad0d4352f8903ce36a59ffe5254b882" STYLE="fork">
        <node TEXT="v_Π(s)是真正的state value，用v_hat(s, w)近似。目标是找到最优的w来拟合。" ID="3b2f733313dd255a290b0e3ec8cff399" STYLE="fork">
          <node TEXT=" 1. uniform distribution：认为每个状态同等重要，每个状态的权重都是1/|S|。" ID="a7846b7e146a033f2c1bfed8cd22538e" STYLE="fork"/>
          <node TEXT="2. stationary distribution：认为是long-run behavior，是达到平稳时state的概率分布" ID="1a2b59887a2910ec5e6ecbcd60b0c57a" STYLE="fork">
            <node TEXT="可以用频率近似估计d_Π(s)" ID="ccd989ad60ccf448feaa47535530f180" STYLE="fork"/>
            <node TEXT="可以通过计算得到d_Π(s)：P_Π是从s到s&apos;的状态转移矩阵（贝尔曼公式矩阵形式），d_Π是P_Π的特征向量，对应的特征值是1" ID="6be038dfd1eba584aed0319576e8148e" STYLE="fork"/>
          </node>
        </node>
      </node>
      <node TEXT="Optimization algorithm" ID="2caa2e6762f743180b37eff1163dd234" STYLE="fork">
        <node TEXT="最小化目标函数，使用GD：" ID="c5182f868459f332f6853b96d939cac9" STYLE="fork"/>
        <node TEXT="进一步，使用SGD：避免求期望" ID="de0ff2bae08c807775202d7260660034" STYLE="fork"/>
        <node TEXT="但是，实际上v_Π(s_t)是无法得知的：" ID="783046fd0312386c84bf5564e774fd65" STYLE="fork">
          <node TEXT="1. Monte Carlo learning with function approximation: 令 g_t 表示从 s_t 开始的episode的return，用 g_t 来近似v_Π(s_t)" ID="119203b64860822daa117c111eb136ec" STYLE="fork"/>
          <node TEXT="2. TD learning with function approximation: 用TD target来近似估计v_Π(s_t)" ID="16c3f455fbef6e6809186cda4046a4e2" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="selection of function approximators" ID="d651c8475082f405372e215faa5e1d5b" STYLE="fork">
        <node TEXT="估计v_hat(s, w) 的函数选取" ID="36477b25290ab0543e98ccfeb3e9de50" STYLE="fork">
          <node TEXT="1. linear" ID="6e0e0c8bdd70f349316b8eec0e93cbf9" STYLE="fork">
            <node TEXT="代入TD算法中" ID="01b232b7839e502605fbfbaf26795551" STYLE="fork"/>
            <node TEXT="很难选出合适的feature vector" ID="48ae27747642d111c486c88f7e2f941e" STYLE="fork"/>
          </node>
          <node TEXT="2. nonlinear: 使用神经网络，网络的参数是w，输入是state，输出是估计值v_hat(s, w)" ID="1a63e4ee124232c4a70305ac2760de9f" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="Sarsa with function approximation" ID="bc4036104c223d66ecd927b685afb4e9" STYLE="fork">
        <node TEXT="估计action value" ID="63550387d27d6a2e3a16a360898848e0" STYLE="fork"/>
      </node>
      <node TEXT="Q-learning with function approximation" ID="94cec9aa6fa31ee9cd579402729b0608" STYLE="fork">
        <node TEXT="" ID="80cc153f56dd9e8b7a0ac61f980e3166" STYLE="fork"/>
      </node>
      <node TEXT="Deep Q-learning (DQN, deep Q-network)" ID="c143eb6c3eae4afcc41a8f1cb3570412" STYLE="fork">
        <node TEXT="损失函数" ID="c1f6bc8b5b3cd1e6791c0a17cbe36c87" STYLE="fork"/>
        <node TEXT="最小化损失函数：GD" ID="10ffc7e58b0af041772d7c41131310d5" STYLE="fork">
          <node TEXT="如何计算梯度：前半部分其实是target q-value，其参数w是固定的，不计算梯度，只需要计算后面部分current q-value的梯度。" ID="a83f4c75b3dee3384a1cfb5c56bed7d2" STYLE="fork"/>
          <node TEXT="引入两个网络，main network 和 target network。通过固定 target network中的参数w_T，相当于在短时间内优化 main network中的参数w 使其逼近一个稳定的目标。而 target network中的参数w_T 每隔若干步才更新一次，避免了 Q 值的剧烈波动" ID="78a314a1adf87270f162eafdc89dd47e" STYLE="fork"/>
          <node TEXT="Experience replay 经验回放：" ID="871bca43cb51ac18844f1e7f2eac5811" STYLE="fork">
            <node TEXT="含义" ID="2afdf8895be0a94f51522a9f0021ee05" STYLE="fork"/>
            <node TEXT="Why experience replay and why uniform distribution：在缺乏先验知识的基础上，假设(S, A)服从均匀分布" ID="15ce7c7fd8c9b18af30aef7248d63347" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="off-policy version：" ID="87a905d5b45daa091405386d4ea9ba44" STYLE="fork"/>
      </node>
    </node>
    <node TEXT="Policy Function Approximation" ID="56f713ad3353968f5cef891baf43aeb2" STYLE="bubble" POSITION="right">
      <node TEXT="之前的方法都是value based，本次的算法是policy based。Π(a | s, θ )， 其中θ是一个参数向量" ID="33ef5e00f7ab05509d143b26bef562e4" STYLE="fork"/>
      <node TEXT="Metrics：to define optimal policies" ID="f3144d9de8bcf36d8a6fe354a2dbd1d6" STYLE="fork">
        <node TEXT="1. average state value： 加权平均" ID="1fa77ee40beabe1ffb1c5b429d361fd7" STYLE="fork">
          <node TEXT="此时如何选择 d(s)：" ID="2712e8a3fd3e5542cddd1a4cbc9dcb3e" STYLE="fork">
            <node TEXT="第一种：d 和 Π independent" ID="4ae037d655d11e478ab54203a6f6019c" STYLE="fork">
              <node TEXT="那么求 v_Π-bar 的梯度就只需要求 v_Π 对Π的梯度，不需要求d对Π的梯度" ID="7d03d6e93e0712884cc7d4b62ee8b95d" STYLE="fork"/>
              <node TEXT="记此时的 d 为 d_0，令d_0(s) = 1/|S|，得到均匀分布；" ID="60a372451ac01fc266e2f173f6e5e1fe" STYLE="fork"/>
              <node TEXT="或者，很关心某一个特定state s_0，令d_0(s_0)=1, d_0(s ≠ s_0)=0，此时 v_Π-bar = v_Π(s_0)" ID="69e6811b7a8b70f3ca2405503dcba7f7" STYLE="fork"/>
            </node>
            <node TEXT="第二种：d depends on Π" ID="806517e3a4f23cfc7fb1956fce55d1f1" STYLE="fork">
              <node TEXT="记此时的 d 为 d_Π(s)，是上一节中提到的stationary distribution" ID="8673865e131d741b94381b3cbd37fce6" STYLE="fork"/>
            </node>
          </node>
        </node>
        <node TEXT="average state value 的第二种形式：" ID="966021961278f9763d2763fb98bd092e" STYLE="fork"/>
        <node TEXT="2. average one-step reward：是从state s出发可以得到的一步即时reward的平均值" ID="d9a1ba242ef77b6176393d51302e5c52" STYLE="fork"/>
        <node TEXT="average one-step reward 的第二种形式：根据一个给定的策略生成了一个trajectory，并有 (R_t+1, R_t+2, R_t+3, ...) 的rewards" ID="4302bdeb983ec1ed7ce7caea666335ed" STYLE="fork">
          <node TEXT="n→∞，跑了无穷多步后，从哪一步开始S_t=s_0已经不重要了，可以省去" ID="9919c948039e6c6d0180f22d1badb7dd" STYLE="fork"/>
        </node>
        <node TEXT="所有的metrics都是Π的函数，Π是由参数θ决定的，故metrics也是关于θ的函数，不同的θ会产生不同的metric values。可以找到最优的θ来使得metric最优" ID="aab772ad6c9e78785dbe1b3dccc0165b" STYLE="fork"/>
        <node TEXT="两种metrics是等价的：" ID="dbf98a993b5507914dcef8c1aa77bb8c" STYLE="fork"/>
      </node>
      <node TEXT="Gradients of the metrics" ID="1c7a0e5ef4e8fb381c2b4928a76b1330" STYLE="fork">
        <node TEXT="可以写作：写成期望的形式便于用采样来模拟期望" ID="b9e318cdae5179f371d5ca3b0a44583f" STYLE="fork"/>
        <node TEXT="为了做ln(·)操作，要求 Π 必须满足 Π(a|s, θ) &gt;0，可以用softmax方式归一化" ID="f61bb2fff8e89fd4c83a1982e794f2ff" STYLE="fork"/>
      </node>
      <node TEXT="Gradient-ascent algorithm (REINFORCE)" ID="74b15716c61967f6b0ef0cb5fd0c55d2" STYLE="fork">
        <node TEXT="最大化 J(θ)" ID="1cb5806157d33e9d3353b50861732d66" STYLE="fork">
          <node TEXT="如何采样 S 和 A 以估计真实的期望：" ID="bda9ff7e1cb7b7e2c16e98dca5a93e1a" STYLE="fork">
            <node TEXT="对于S：S ~ d，经过策略Π不断迭代得到d，然后再采样S。实际上不必等long-run behavior平稳后再采样；" ID="d704c51d2229c4b0b50df1cebc379510" STYLE="fork"/>
            <node TEXT="对于A：A ~ Π(A | S, θ)，因此 a_t 应该是根据 s_t 处的策略 Π(θ_t) 进行采样" ID="cdd19222a5f6540a3aeb0929f55db4f1" STYLE="fork"/>
            <node TEXT="可见，这个policy gradient方法其实是on-policy的" ID="6ef16f6b13a6a04c6e48d6fc12322962" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="REINFORCE: 用蒙特卡罗的方法估计 qt(st, at)" ID="1f1a132dd8bbf19186eeed270aeaf258" STYLE="fork"/>
      </node>
    </node>
    <node TEXT="Actor-Critic Methods" ID="117a56f5712df494668b4f206a4daa32" STYLE="bubble" POSITION="right">
      <node TEXT="用TD的方法估计 qt(st, at)" ID="2f74a94b078c9b37b0b16e2953f18e0f" STYLE="fork"/>
      <node TEXT="The simplest actor-critic (QAC)" ID="e4bb64aeec1e48c857b55bcf5551d2be" STYLE="fork">
        <node TEXT="实际上就是 Sarsa + value function approximation；" ID="f1e7cd65d8722ecfa61edaf44d7359d0" STYLE="fork"/>
        <node TEXT="是 on-policy的" ID="9404cdf4b52c4b3448f6b8f255509fe8" STYLE="fork"/>
      </node>
      <node TEXT="Advantage actor-critic (A2C)：引入一个baseline偏置量来减少方差" ID="ec5c0048523d17431d920a51711c98b6" STYLE="fork">
        <node TEXT="性质：policy gradient 引入一个新的baseline b(S)，其值保持不变" ID="f1495434854145e80876ec0730a3c933" STYLE="fork"/>
        <node TEXT="选择 optimal baseline 使得 var 最小" ID="a5042d0ac4afdedabd712de9e254656a" STYLE="fork"/>
        <node TEXT="但是，这样的 b(s) 比较复杂，可以去掉权重，得到的 b(s) 实际上是 s 的state value：" ID="8b0f1d215a9545418a9874e4bba016f3" STYLE="fork"/>
        <node TEXT="advantage function：" ID="317b994a4a386e9dc69a675c81a4099d" STYLE="fork">
          <node TEXT="v_Π(S) 实际上是 q_Π(S,A)在某个状态下action的平均值，所以δ_Π(S,A)描述的是当前action和同状态下的其他action相比的优劣" ID="6ae539bd11177eb320f412b3c99f1a8a" STYLE="fork"/>
        </node>
        <node TEXT="算法：" ID="ae75906c97439fa6686b912d43ff7dae" STYLE="fork"/>
      </node>
      <node TEXT="Off-policy actor-critic" ID="cbce9045899109a80f2cfc116c161590" STYLE="fork">
        <node TEXT="importance sampling 重要性采样" ID="5151414877d65d29df65fc06c0a04d39" STYLE="fork">
          <node TEXT="p0/p1 称为 importance weight" ID="9fd6d990aebd345acebba57c33476c0b" STYLE="fork"/>
        </node>
        <node TEXT="off-policy policy gradient" ID="be26f60ac23dfe76f76d12c451984f68" STYLE="fork"/>
        <node TEXT="算法：" ID="ce171674807b20e523023184b2c9fa1a" STYLE="fork">
          <node TEXT="依旧可以设置一个baseline b(S)=v_Π(S)" ID="3eedb7fbee8ff0ef17718408861c245c" STYLE="fork"/>
          <node TEXT="然后再考虑 stochastic gradient-ascent，最终算法为：" ID="2c1b4840be9eb593ea4e1fc932bd8fde" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="Deterministic actor-critic (DPG)" ID="b908a86ff020211e2edf7c5bfbb77e73" STYLE="fork">
        <node TEXT="和之前的QAC、A2C、off-policy的actor-critic相比最大的不同是，策略 Π(a|s,θ) 可以不用严格大于0。因此，action的个数从有限个推广到了无限个。" ID="a674699ed6503ef357d5bc980eb9bca3" STYLE="fork"/>
        <node TEXT=" 梯度" ID="71d83392732446a5dc0273a4e40c6733" STYLE="fork">
          <node TEXT="不涉及到action A。因为被替换成了μ(S)。" ID="7b043dfb7439e2eaba2b8cfa0d8326b5" STYLE="fork"/>
          <node TEXT="由于不再关心A是通过哪个策略得到的了，所以是off-policy" ID="2bf18121ff6f6ce1f0bd083419539a4d" STYLE="fork"/>
        </node>
        <node TEXT="梯度上升优化" ID="faab03083bd5d603ec2543176a1927d3" STYLE="fork"/>
      </node>
    </node>
  </node>
</map>