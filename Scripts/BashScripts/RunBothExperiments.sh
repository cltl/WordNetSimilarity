#create output directories

mkdir -p ../../Output/AllPosCross
mkdir ../../Output/AllPosId
mkdir ../../Output/NounsOnly
mkdir -p ../../Output/PairWise/AllPosCross
mkdir ../../Output/PairWise/AllPosId
mkdir ../../Output/PairWise/NounsOnly

./RunFullWN3.0Exp.sh
./RunFullWN2.1Exp.sh

