#include <iostream>
#include <string>
#include <fstream>
#include <stdlib.h>
#include <ctime>
#include<vector>
#include <cmath>
#include <math.h>  
#include <cstdlib>
#include <iomanip> 
#include <algorithm>

using namespace std;

float thresholdForWillisonAmplitude = 0.099;
float thresholdForMyopulsePercentageRate = 2.5;

vector<vector<float> > dataSignals;
vector<string> fileNames; 
vector<float> featureMeans;
vector<float> featureMeanAbsoluteDeviations;
vector<float> featureVariances;
vector<float> featureAverageAmplitudeChanges;
vector<float> featureRootMeanSquares;
vector<float> featureSimpleSquareIntegrals;
vector<float> featureIntegratedEMGs;
vector<float> featureWaveformLengths;
vector<float> featureWillisonAmplitudes;
vector<float> featureLogDetectors;
vector<float> featureDifferenceAbsoluteStandardDeviationValues;
vector<float> featureMyopulsePercentageRates;
vector<float> featureModifiedMeanAbsoluteValue1s;
vector<float> featureModifiedMeanAbsoluteValue2s;
vector<float> featureMinimums;
vector<float> featureMaximums;
vector<vector<float> > featureNoise;
vector<float> featureModes;
float weights[] = {48,48,48,71,71,71,71,71,65,65,65,65,65,77,77,77,77,77,62,62,62,62,81,81,81,81,81,72,72,72,72,72,52,52,61,61,61,52,52,52};
float heights[] = {164,164,164,170,170,170,170,170,163,163,163,163,163,175,175,175,175,175,180,180,180,180,193,193,193,193,193,170,170,170,170,170,163,163,168,168,168,160,160,160};
float usedWeights[] = {1,3,5,3,5,7.5,10,12.5,3,5,7.5,10,12.5,3,5,7.5,10,12.5,3,5,10,12.5,3,5,7.5,10,12.5,3,5,7.5,10,12.5,3,5,5,7.5,10,3,5,7.5};
float bicepsSize[] = {22.5,22.5,22.5,32.5,32.5,32.5,32.5,32.5,32.5,32.5,32.5,32.5,32.5,35,35,35,35,35,31.5,31.5,31.5,31.5,38,38,38,38,38,32.5,32.5,32.5,32.5,32.5,23.5,23.5,25,25,25,25,25,25};
float genders[] = {0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,0,0,0};
vector<float> featureBodyIndexes;

void fileNamesPush(){
	fileNames.push_back("data_collecting/sule_soylu_1kg_21_04.txt");
	fileNames.push_back("data_collecting/sule_soylu_3kg_21_04.txt");
	fileNames.push_back("data_collecting/sule_soylu_5kg_21_04.txt");
	fileNames.push_back("data_collecting/faruk_guc_3kg_21_04.txt");
	fileNames.push_back("data_collecting/faruk_guc_5kg_21_04.txt");
	fileNames.push_back("data_collecting/faruk_guc_7,5kg_21_04.txt");
	fileNames.push_back("data_collecting/faruk_guc_10kg_21_04.txt");
	fileNames.push_back("data_collecting/faruk_guc_12,5kg_21_04.txt");
	fileNames.push_back("data_collecting/mucahit_gemici_3kg_21_04.txt");
	fileNames.push_back("data_collecting/mucahit_gemici_5kg_21_04.txt");
	fileNames.push_back("data_collecting/mucahit_gemici_7,5kg_21_04.txt");
	fileNames.push_back("data_collecting/mucahit_gemici_10kg_21_04.txt");
	fileNames.push_back("data_collecting/mucahit_gemici_12,5kg_21_04.txt");
	fileNames.push_back("data_collecting/nail_tugberk_ayhan_3kg_21_04.txt");
	fileNames.push_back("data_collecting/nail_tugberk_ayhan_5kg_21_04.txt");
	fileNames.push_back("data_collecting/nail_tugberk_ayhan_7,5kg_21_04.txt");
	fileNames.push_back("data_collecting/nail_tugberk_ayhan_10kg_21_04.txt");
	fileNames.push_back("data_collecting/nail_tugberk_ayhan_12,5kg_21_04.txt");
	fileNames.push_back("data_collecting/yusuf_abdal_3kg_21_04.txt");
	fileNames.push_back("data_collecting/yusuf_abdal_5kg_21_04.txt");
	fileNames.push_back("data_collecting/yusuf_abdal_10kg_21_04.txt");
	fileNames.push_back("data_collecting/yusuf_abdal_12,5kg_21_04.txt");
	fileNames.push_back("data_collecting/yilmaz_can_ekmekci_3kg_21_04.txt");
	fileNames.push_back("data_collecting/yilmaz_can_ekmekci_5kg_21_04.txt");
	fileNames.push_back("data_collecting/yilmaz_can_ekmekci_7,5kg_21_04.txt");
	fileNames.push_back("data_collecting/yilmaz_can_ekmekci_10kg_21_04.txt");
	fileNames.push_back("data_collecting/yilmaz_can_ekmekci_12,5kg_21_04.txt");
	fileNames.push_back("data_collecting/kazim_kormaz_3kg_21_04.txt");
	fileNames.push_back("data_collecting/kazim_kormaz_5kg_21_04.txt");
	fileNames.push_back("data_collecting/kazim_kormaz_7,5kg_21_04.txt");
	fileNames.push_back("data_collecting/kazim_kormaz_10kg_21_04.txt");
	fileNames.push_back("data_collecting/kazim_kormaz_12,5kg_21_04.txt");
	fileNames.push_back("data_collecting/gizem_dursun_3kg_21_04.txt");
	fileNames.push_back("data_collecting/gizem_dursun_5kg_21_04.txt");
	fileNames.push_back("data_collecting/cem_altiparmak_5kg_21_04.txt");
	fileNames.push_back("data_collecting/cem_altiparmak_7,5kg_21_04.txt");
	fileNames.push_back("data_collecting/cem_altiparmak_10kg_21_04.txt");
	fileNames.push_back("data_collecting/hanife_soysal_3kg_21_04.txt");
	fileNames.push_back("data_collecting/hanife_soysal_5kg_21_04.txt");
	fileNames.push_back("data_collecting/hanife_soysal_7,5kg_21_04.txt");
	fileNames.push_back("data_collecting/1.txt");
	fileNames.push_back("data_collecting/2.txt");
	fileNames.push_back("data_collecting/3.txt");
	fileNames.push_back("data_collecting/4.txt");
	fileNames.push_back("data_collecting/5.txt");
	fileNames.push_back("data_collecting/6.txt");
	fileNames.push_back("data_collecting/7.txt");
	fileNames.push_back("data_collecting/8.txt");
	fileNames.push_back("data_collecting/9.txt");
	fileNames.push_back("data_collecting/10.txt");
	fileNames.push_back("data_collecting/11.txt");
	fileNames.push_back("data_collecting/12.txt");
	fileNames.push_back("data_collecting/13.txt");
	fileNames.push_back("data_collecting/14.txt");
	fileNames.push_back("data_collecting/15.txt");
	fileNames.push_back("data_collecting/16.txt");
	fileNames.push_back("data_collecting/17.txt");
	fileNames.push_back("data_collecting/18.txt");
	fileNames.push_back("data_collecting/19.txt");
	fileNames.push_back("data_collecting/20.txt");
	fileNames.push_back("data_collecting/21.txt");
	fileNames.push_back("data_collecting/22.txt");
	fileNames.push_back("data_collecting/23.txt");
	fileNames.push_back("data_collecting/24.txt");
	fileNames.push_back("data_collecting/25.txt");
	fileNames.push_back("data_collecting/26.txt");
	fileNames.push_back("data_collecting/27.txt");
	fileNames.push_back("data_collecting/28.txt");
	fileNames.push_back("data_collecting/29.txt");
	fileNames.push_back("data_collecting/30.txt");
	fileNames.push_back("data_collecting/31.txt");
	fileNames.push_back("data_collecting/32.txt");
	fileNames.push_back("data_collecting/33.txt");
	fileNames.push_back("data_collecting/34.txt");
	fileNames.push_back("data_collecting/35.txt");
	fileNames.push_back("data_collecting/36.txt");
	fileNames.push_back("data_collecting/37.txt");
	fileNames.push_back("data_collecting/38.txt");
	fileNames.push_back("data_collecting/39.txt");
	fileNames.push_back("data_collecting/40.txt");
	fileNames.push_back("data_collecting/41.txt");
	fileNames.push_back("data_collecting/42.txt");
	fileNames.push_back("data_collecting/43.txt");
	fileNames.push_back("data_collecting/44.txt");
	fileNames.push_back("data_collecting/45.txt");
	fileNames.push_back("data_collecting/46.txt");
	fileNames.push_back("data_collecting/47.txt");
	fileNames.push_back("data_collecting/48.txt");
	fileNames.push_back("data_collecting/49.txt");
	fileNames.push_back("data_collecting/50.txt");
	fileNames.push_back("data_collecting/51.txt");
	fileNames.push_back("data_collecting/52.txt");
	fileNames.push_back("data_collecting/53.txt");
	fileNames.push_back("data_collecting/54.txt");
	fileNames.push_back("data_collecting/55.txt");
	fileNames.push_back("data_collecting/56.txt");
	fileNames.push_back("data_collecting/57.txt");
	fileNames.push_back("data_collecting/58.txt");
	fileNames.push_back("data_collecting/59.txt");
	fileNames.push_back("data_collecting/60.txt");
	fileNames.push_back("data_collecting/61.txt");
	fileNames.push_back("data_collecting/62.txt");
	fileNames.push_back("data_collecting/63.txt");
	fileNames.push_back("data_collecting/64.txt");
	fileNames.push_back("data_collecting/65.txt");
	fileNames.push_back("data_collecting/66.txt");
	fileNames.push_back("data_collecting/67.txt");
	fileNames.push_back("data_collecting/68.txt");
	fileNames.push_back("data_collecting/69.txt");
	fileNames.push_back("data_collecting/70.txt");
	fileNames.push_back("data_collecting/71.txt");
	fileNames.push_back("data_collecting/72.txt");
	fileNames.push_back("data_collecting/73.txt");
	fileNames.push_back("data_collecting/74.txt");
	fileNames.push_back("data_collecting/75.txt");
	fileNames.push_back("data_collecting/76.txt");
	fileNames.push_back("data_collecting/77.txt");
	fileNames.push_back("data_collecting/78.txt");
	fileNames.push_back("data_collecting/79.txt");
	fileNames.push_back("data_collecting/80.txt");
	fileNames.push_back("data_collecting/81.txt");
	fileNames.push_back("data_collecting/82.txt");
	fileNames.push_back("data_collecting/83.txt");
	fileNames.push_back("data_collecting/84.txt");
	fileNames.push_back("data_collecting/85.txt");
	fileNames.push_back("data_collecting/86.txt");
	fileNames.push_back("data_collecting/87.txt");
	fileNames.push_back("data_collecting/88.txt");
	fileNames.push_back("data_collecting/89.txt");
	fileNames.push_back("data_collecting/90.txt");
	fileNames.push_back("data_collecting/91.txt");
	fileNames.push_back("data_collecting/92.txt");
	fileNames.push_back("data_collecting/93.txt");
	fileNames.push_back("data_collecting/94.txt");
	fileNames.push_back("data_collecting/95.txt");
	fileNames.push_back("data_collecting/96.txt");
	fileNames.push_back("data_collecting/97.txt");
	fileNames.push_back("data_collecting/98.txt");
	fileNames.push_back("data_collecting/99.txt");
	fileNames.push_back("data_collecting/100.txt");
	fileNames.push_back("data_collecting/101.txt");
	fileNames.push_back("data_collecting/102.txt");
	fileNames.push_back("data_collecting/103.txt");
	fileNames.push_back("data_collecting/104.txt");
	fileNames.push_back("data_collecting/105.txt");
	fileNames.push_back("data_collecting/106.txt");
	fileNames.push_back("data_collecting/107.txt");
	fileNames.push_back("data_collecting/108.txt");
	fileNames.push_back("data_collecting/109.txt");
	fileNames.push_back("data_collecting/110.txt");
	fileNames.push_back("data_collecting/111.txt");
	fileNames.push_back("data_collecting/112.txt");
	fileNames.push_back("data_collecting/113.txt");
	fileNames.push_back("data_collecting/114.txt");
	fileNames.push_back("data_collecting/115.txt");
	fileNames.push_back("data_collecting/116.txt");
	fileNames.push_back("data_collecting/117.txt");
	fileNames.push_back("data_collecting/118.txt");
	fileNames.push_back("data_collecting/119.txt");
	fileNames.push_back("data_collecting/120.txt");
	fileNames.push_back("data_collecting/121.txt");
	fileNames.push_back("data_collecting/122.txt");
	fileNames.push_back("data_collecting/123.txt");
	fileNames.push_back("data_collecting/124.txt");
	fileNames.push_back("data_collecting/125.txt");
	fileNames.push_back("data_collecting/126.txt");
	fileNames.push_back("data_collecting/127.txt");
	fileNames.push_back("data_collecting/128.txt");
	fileNames.push_back("data_collecting/129.txt");
	fileNames.push_back("data_collecting/130.txt");
	fileNames.push_back("data_collecting/131.txt");
	fileNames.push_back("data_collecting/132.txt");
	fileNames.push_back("data_collecting/133.txt");
	fileNames.push_back("data_collecting/134.txt");
	fileNames.push_back("data_collecting/135.txt");
	fileNames.push_back("data_collecting/136.txt");
	fileNames.push_back("data_collecting/137.txt");
	fileNames.push_back("data_collecting/138.txt");
	fileNames.push_back("data_collecting/139.txt");
	fileNames.push_back("data_collecting/140.txt");
	fileNames.push_back("data_collecting/141.txt");
	fileNames.push_back("data_collecting/142.txt");
	fileNames.push_back("data_collecting/143.txt");
	fileNames.push_back("data_collecting/144.txt");
	fileNames.push_back("data_collecting/145.txt");
	fileNames.push_back("data_collecting/146.txt");
	fileNames.push_back("data_collecting/147.txt");
	fileNames.push_back("data_collecting/148.txt");
	fileNames.push_back("data_collecting/149.txt");
	fileNames.push_back("data_collecting/150.txt");
	fileNames.push_back("data_collecting/151.txt");
	fileNames.push_back("data_collecting/152.txt");
	fileNames.push_back("data_collecting/153.txt");
	fileNames.push_back("data_collecting/154.txt");
	fileNames.push_back("data_collecting/155.txt");
	fileNames.push_back("data_collecting/156.txt");
	fileNames.push_back("data_collecting/157.txt");
	fileNames.push_back("data_collecting/158.txt");
	fileNames.push_back("data_collecting/159.txt");
	fileNames.push_back("data_collecting/160.txt");
	fileNames.push_back("data_collecting/161.txt");
	fileNames.push_back("data_collecting/162.txt");
	fileNames.push_back("data_collecting/163.txt");
	fileNames.push_back("data_collecting/164.txt");
	fileNames.push_back("data_collecting/165.txt");
	fileNames.push_back("data_collecting/166.txt");
	fileNames.push_back("data_collecting/167.txt");
	fileNames.push_back("data_collecting/168.txt");
	fileNames.push_back("data_collecting/169.txt");
	fileNames.push_back("data_collecting/170.txt");
	fileNames.push_back("data_collecting/171.txt");
	fileNames.push_back("data_collecting/172.txt");
	fileNames.push_back("data_collecting/173.txt");
	fileNames.push_back("data_collecting/174.txt");
	fileNames.push_back("data_collecting/175.txt");
}

void Means(){
	for(int i = 0; i<dataSignals.size(); i++){
		float total = 0;		
		for(int j = 0; j<dataSignals[i].size(); j++){
			if(dataSignals[i].at(j)>=0){
				total += dataSignals[i].at(j);
			}else{
				total -= dataSignals[i].at(j);
			}
		}
		float mean = total/dataSignals[i].size();
		featureMeans.push_back(mean);
	}
}

void MeanAbsoluteDeviations(){
	
	for(int i = 0; i<dataSignals.size(); i++){
		vector<float> differences;
		float difference = 0;		
		for(int j = 0; j<dataSignals[i].size(); j++){
			difference = featureMeans.at(i) - dataSignals[i].at(j);
			if(difference<0){
				difference = - difference;
			}
			differences.push_back(difference);
		}
		float total = 0;		
		for(int j = 0; j<differences.size(); j++){
			total += differences.at(j);
		}
		float meanAbsoluteDeviation = total/differences.size();
		featureMeanAbsoluteDeviations.push_back(meanAbsoluteDeviation);
	}
}

void Variances(){
    for(int i = 0; i<dataSignals.size(); i++){
		vector<float> differences;
		float difference = 0;
		for(int j = 0; j<dataSignals[i].size(); j++){
			difference = dataSignals[i].at(j) - featureMeans.at(i);
			difference = difference*difference;
			differences.push_back(difference);
		}
		float total = 0;
		for(int j = 0; j<differences.size();j++){
			total += differences.at(j);
		}
		float variance = total/(differences.size()-1);
		featureVariances.push_back(variance);
	}
}

void AverageAmplitudeChanges(){
	for(int i = 0; i<dataSignals.size(); i++){
		vector<float> differences;
		float difference = 0;
		for(int j = 1; j<dataSignals[i].size();j++){
			difference = dataSignals[i].at(j)-dataSignals[i].at(j-1);
			if(difference<0){
				difference = -difference;
			}
			differences.push_back(difference);
		}
		float total = 0;
		for(int j = 0; j<differences.size();j++){
			total += differences.at(j);
		}
		float averageAmplitudeChange = total/differences.size();
		featureAverageAmplitudeChanges.push_back(averageAmplitudeChange);
	}
}

void RootMeanSquares(){
	for(int i = 0; i<dataSignals.size(); i++){
		float total = 0;
		for(int j = 0; j<dataSignals[i].size();j++){
			total += dataSignals[i].at(j)*dataSignals[i].at(j);
		}
		float rootMeanSquare = sqrt(total/dataSignals[i].size());
		featureRootMeanSquares.push_back(rootMeanSquare);
	}
}

void SimpleSquareIntegrals(){
	for(int i = 0; i<dataSignals.size(); i++){
		vector<float> differences;
		float difference = 0;
		for(int j = 0; j<dataSignals[i].size(); j++){
			difference = dataSignals[i].at(j) - featureMeans.at(i);
			difference = difference*difference;
			differences.push_back(difference);
		}
		float simpleSquareIntegral = 0;
		for(int j = 0; j<differences.size();j++){
			simpleSquareIntegral += differences.at(j);
		}
		featureSimpleSquareIntegrals.push_back(simpleSquareIntegral);
	}
}
void IntegratedEMGs(){
	for(int i = 0; i<dataSignals.size(); i++){
		float integratedEMG = 0;		
		for(int j = 0; j<dataSignals[i].size(); j++){
			if(dataSignals[i].at(j)>=0){
			    integratedEMG += dataSignals[i].at(j);	
			}else{
				integratedEMG -= dataSignals[i].at(j);
			}
		}
		featureIntegratedEMGs.push_back(integratedEMG);
	}
}

void WaveformLengths(){
	for(int i = 0; i<dataSignals.size(); i++){
		vector<float> differences;
		float difference = 0;
		for(int j = 1; j<dataSignals[i].size();j++){
			difference = dataSignals[i].at(j)-dataSignals[i].at(j-1);
			if(difference<0){
				difference = -difference;
			}
			differences.push_back(difference);
		}
		float waveFormLength = 0;
		for(int j = 0; j<differences.size();j++){
			waveFormLength += differences.at(j);
		}
		featureWaveformLengths.push_back(waveFormLength);
	}
}

void WillisonAmplitudes(){
	for(int i = 0; i<dataSignals.size(); i++){
		thresholdForWillisonAmplitude = featureAverageAmplitudeChanges.at(i);
		float willisonAmplitude=0;
		float difference = 0;
		for(int j = 1; j<dataSignals[i].size();j++){
			difference = dataSignals[i].at(j)-dataSignals[i].at(j-1);
			if(difference<0){
				difference = -difference;
			}
			
			if(difference>=thresholdForWillisonAmplitude){
				willisonAmplitude+=1;
			}
		}
		willisonAmplitude=willisonAmplitude/(dataSignals[i].size()-1);
		featureWillisonAmplitudes.push_back(willisonAmplitude);
	}
}

void LogDetectors(){
	for(int i = 0; i<dataSignals.size(); i++){
		vector<float> logs;
		for(int j = 0; j<dataSignals[i].size();j++){
			float log = log10(abs(dataSignals[i].at(j)));
			logs.push_back(log);
		}
		float totalLogs=0;
		for(int j = 0; j<logs.size();j++){
			totalLogs+=logs.at(j);
		}
		float logDetector = exp(totalLogs/logs.size());
		featureLogDetectors.push_back(logDetector);
	}
}

void DifferenceAbsoluteStandardDeviationValues(){
	for(int i = 0; i<dataSignals.size(); i++){
		vector<float> differences;
		float difference = 0;
		for(int j = 1; j<dataSignals[i].size();j++){
			difference = dataSignals[i].at(j)-dataSignals[i].at(j-1);
			difference = difference*difference;
			differences.push_back(difference);
		}
		float totalDifferences=0;
		for(int j = 0; j<differences.size();j++){
			totalDifferences+=differences.at(j);
		}
		float differenceAbsoluteStandardDeviationValue = sqrt(totalDifferences/(differences.size()-1));
		featureDifferenceAbsoluteStandardDeviationValues.push_back(differenceAbsoluteStandardDeviationValue);
	}
}

void MyopulsePercentageRates(){
	for(int i = 0; i<dataSignals.size(); i++){
		thresholdForMyopulsePercentageRate = featureMeans.at(i);
		float myopulse=0;
		for(int j = 0; j<dataSignals[i].size();j++){
			if(dataSignals[i].at(j)>=thresholdForMyopulsePercentageRate){
				myopulse+=1;
			}
		}
		float myopulsePercentageRate = myopulse/dataSignals[i].size();
		featureMyopulsePercentageRates.push_back(myopulsePercentageRate);
	}
}

void ModifiedMeanAbsoluteValue1s(){
	for(int i = 0; i<dataSignals.size(); i++){
		vector<float> sum;
		for(int j = 0; j<dataSignals[i].size();j++){
			float wN = 0;
			if(0.25*dataSignals[i].size() <= (j+1) && (j+1) <= 0.75*dataSignals[i].size()){
				wN = 1;
			}else{
				wN = 0.5;
			}
			float value = wN*abs(dataSignals[i].at(j));
			sum.push_back(value);
		}
		float total =0;
		for(int j = 0; j<sum.size();j++){
			total+=sum.at(j);
		}
		float modifiedMeanAbsoluteValue1 = total/dataSignals[i].size();
		featureModifiedMeanAbsoluteValue1s.push_back(modifiedMeanAbsoluteValue1);
	}
}

void ModifiedMeanAbsoluteValue2s(){
	for(int i = 0; i<dataSignals.size(); i++){
		vector<float> sum;
		for(int j = 0; j<dataSignals[i].size();j++){
			float wN = 0;
			if(0.25*dataSignals[i].size() <= (j+1) && (j+1) <= 0.75*dataSignals[i].size()){
				wN = 1;
			}else if(0.25*dataSignals[i].size() > (j+1)){
				wN = (4*(j+1))/dataSignals[i].size();
			}else{
				wN = (4*((j+1)-dataSignals[i].size()))/dataSignals[i].size();
			}
			float value = wN*abs(dataSignals[i].at(j));
			sum.push_back(value);
		}
		float total =0;
		for(int j = 0; j<sum.size();j++){
			total+=sum.at(j);
		}
		float modifiedMeanAbsoluteValue2 = total/dataSignals[i].size();
		featureModifiedMeanAbsoluteValue2s.push_back(modifiedMeanAbsoluteValue2);
		//cout<<modifiedMeanAbsoluteValue2<<"\n";
	}
}

void Minimums(){
	for(int i = 0; i<dataSignals.size();i++){
		float minimum;
		for(int j = 0; j<dataSignals[i].size();j++){
			if(j == 0){
				minimum = dataSignals[i].at(j);
			}else{
				if(minimum>dataSignals[i].at(j)){
					minimum = dataSignals[i].at(j);
				}
			}
		}
		featureMinimums.push_back(minimum);
	}
}

void Maximums(){
	for(int i = 0; i<dataSignals.size();i++){
		float maximum;
		for(int j = 0; j<dataSignals[i].size();j++){
			if(j == 0){
				maximum = dataSignals[i].at(j);
			}else{
				if(maximum<dataSignals[i].at(j)){
					maximum = dataSignals[i].at(j);
				}
			}
		}
		featureMaximums.push_back(maximum);
	}
}

void Noise(){
	for(int i = 0; i<dataSignals.size();i++){
		float sum = 0;
		featureNoise.resize(fileNames.size());
		for(int j = 0; j<dataSignals[i].size();j++){
			if(j%12==0){
				if(j!=0){
					featureNoise[i].push_back(sum/12);
				}
				sum = 0;
			}else{
			sum += dataSignals[i].at(j);	
			}
		}
	}
}

void Modes(){
	for(int i =0; i<dataSignals.size();i++){
		vector<float> counts;
		float orderOfMode = 0;
		for(int j = 0; j<dataSignals[i].size();j++){
			counts.push_back(count(dataSignals[i].begin(), dataSignals[i].end(), dataSignals[i].at(j)));
		}
		for(int j = 0; j<dataSignals[i].size();j++){
			if(counts.at(orderOfMode)<counts.at(j)){
				orderOfMode = j;
			}
		}
		featureModes.push_back(dataSignals[i].at(orderOfMode));
	}
}

void BodyIndexes(){
	for(int i =0; i<dataSignals.size();i++){
		float bodyIndex = weights[i]/((heights[i]/100)*(heights[i]/100));
		featureBodyIndexes.push_back(bodyIndex);
	}
}

int main(){
	int fileNumber;
	float temporaryValue;
	
	fileNamesPush();
	fileNumber = fileNames.size();
	dataSignals.resize(fileNumber);
	for(int i = 0; i<fileNumber;i++){
		ifstream myfile;
	    myfile.open (fileNames.at(i).c_str(), ios::in);
	    string line;
	    if ( myfile.is_open() ) {
            while (myfile >> temporaryValue){
                dataSignals[i].push_back(temporaryValue);
            }
        }else {
            std::cout << "Couldn't open file\n";
        }
	}
	
	Means();                                           // MAV
	MeanAbsoluteDeviations();                          // MAD
	Variances();                                       // VAR
	AverageAmplitudeChanges();                         // AAC
	RootMeanSquares();                                 // RMS
	SimpleSquareIntegrals();                           // SSI     (S?reye b?lmeden i?e yaramaz. Sadece de?erlerin karelerinin toplam?n? veriyor)
	IntegratedEMGs();                                  // IEMG    (S?reye b?lmeden i?e yaramaz. Sadece de?erlerin absolute toplam?n? veriyor)
	WaveformLengths();                                 // WL      (S?reye b?lmeden i?e yaramaz. Farklar?n toplam?n? veriyor)
	WillisonAmplitudes();                              // WAMP    (Belli bir e?ik de?erinden fazla sinyal art??lar?n say?s?n? say?yor. Bu da s?reyle do?ru orant?l?. S?reye b?l?nebilir. E?ik de?erini biz belirliyoruz.)
	LogDetectors();                                    // LOG
	DifferenceAbsoluteStandardDeviationValues();       // DASDV
	MyopulsePercentageRates();                         // MYOP    (Belli bir e?ik de?eri ge?en sinyallari say?p y?zdesini veriyor. E?ik de?eri biz belirliyoruz)
	ModifiedMeanAbsoluteValue1s();                     // MMAV1
	ModifiedMeanAbsoluteValue2s();                     // MMAV2
	Minimums();                                        // MIN
	Maximums();                                        // MAX
	//Noise();
	//Modes();
	//BodyIndexes();
	
	cout<<"\n"<<setw(50)<<"featureModes\n\n";
	for(int i = 0; i<fileNames.size(); i++){
		if(i==3||i==8||i==13||i==18||i==22||i==27||i==32||i==34||i==38||i==41) {
			cout<<endl;
		}
		cout<<setw(40)<<fileNames.at(i).substr(16);
		cout<<"  >> "<< featureMeans.at(i) << "   //   " << (bicepsSize[i]*bicepsSize[i])/(weights[i]/((heights[i]/100)*(heights[i]/100)))<<"\n";     // ?stenilen feature buraya yaz?l?r.
	}
	
	ofstream outputFile;
	outputFile.open("output.txt");
	for(int i = 0;i<dataSignals.size();i++){
		/* LSTM
		if(i==130){
			i=160;
		}
		outputFile << featureMeans.at(i)<<" ";
		outputFile << featureMeanAbsoluteDeviations.at(i)<<" ";
		outputFile << featureVariances.at(i)<<" ";
		outputFile << featureAverageAmplitudeChanges.at(i)<<" ";
		outputFile << featureRootMeanSquares.at(i)<<" ";
		outputFile << featureSimpleSquareIntegrals.at(i)<<" ";
		outputFile << featureIntegratedEMGs.at(i)<<" ";
		outputFile << featureWaveformLengths.at(i)<<" ";
		outputFile << featureWillisonAmplitudes.at(i)<<" ";
		outputFile << featureLogDetectors.at(i)<<" ";
		outputFile << featureDifferenceAbsoluteStandardDeviationValues.at(i)<<" ";
		outputFile << featureMyopulsePercentageRates.at(i)<<" ";
		outputFile << featureModifiedMeanAbsoluteValue1s.at(i)<<" ";
		//outputFile << (bicepsSize[i]*bicepsSize[i])/(weights[i]/((heights[i]/100)*(heights[i]/100))) <<" ";
		if(i>=40){
			if(i<50||(i>=70&&i<=89)||(i>169&&i<195)){ //Tu?berk
				outputFile << (bicepsSize[13]*bicepsSize[13])/(weights[13]/((heights[13]/100)*(heights[13]/100))) <<" ";
			}else if((i>=50&&i<70)||(i>194&&i<205)){//M?cahit
			    outputFile << (bicepsSize[8]*bicepsSize[8])/(weights[8]/((heights[8]/100)*(heights[8]/100))) <<" ";
		    }else if((i>=90&&i<115)||(i>204)){//Faruk
		    	outputFile << (bicepsSize[4]*bicepsSize[4])/(weights[4]/((heights[4]/100)*(heights[4]/100))) <<" ";
			}else{//Kaz?m
				outputFile << (bicepsSize[28]*bicepsSize[28])/(weights[28]/((heights[28]/100)*(heights[28]/100))) <<" ";
			}
		}else{
			outputFile << (bicepsSize[i]*bicepsSize[i])/(weights[i]/((heights[i]/100)*(heights[i]/100))) <<" ";
		}
		//outputFile << genders[i] << " ";
		if(i>=40){
			outputFile << genders[4] << " ";
		}else{
			outputFile << genders[i] << " ";
		}
		if(i==dataSignals.size()-1){
			//outputFile << usedWeights[i];
			outputFile << usedWeights[6];
		}else{
			//outputFile << usedWeights[i] <<"\n";
			if(i>=40){
			if(i<50||(i>=70&&i<=89)||(i>169&&i<195)){ //Tu?berk
				if(i<45){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<50){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<75){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<80){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<85){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<90){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<175){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<180){
					outputFile << usedWeights[6] <<"\n";
				}else if(i<185){
					outputFile << usedWeights[7] <<"\n";
				}else if(i<190){
					outputFile << usedWeights[6] <<"\n";
				}else{
					outputFile << usedWeights[7] <<"\n";
				}
			}else if((i>=50&&i<70)||(i>194&&i<205)){//M?cahit
			    if(i<55){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<60){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<65){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<70){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<200){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[6] <<"\n";
				}
		    }else if((i>=90&&i<115)||(i>204)){//Faruk
		    	if(i<95){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<100){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<105){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<110){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<115){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<210){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[6] <<"\n";
				}
			}else{//Kaz?m
				if(i<120){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<125){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<130){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<165){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[6] <<"\n";
				}
			}
		}else{
			outputFile << usedWeights[i] << "\n";
		}
		}*/
		if(i==134){
			i=136;
		}
		outputFile << featureMeans.at(i)<<" ";
		outputFile << featureMeanAbsoluteDeviations.at(i)<<" ";
		outputFile << featureVariances.at(i)<<" ";
		outputFile << featureAverageAmplitudeChanges.at(i)<<" ";
		outputFile << featureRootMeanSquares.at(i)<<" ";
		outputFile << featureSimpleSquareIntegrals.at(i)<<" ";
		outputFile << featureIntegratedEMGs.at(i)<<" ";
		outputFile << featureWaveformLengths.at(i)<<" ";
		outputFile << featureWillisonAmplitudes.at(i)<<" ";
		outputFile << featureLogDetectors.at(i)<<" ";
		outputFile << featureDifferenceAbsoluteStandardDeviationValues.at(i)<<" ";
		outputFile << featureMyopulsePercentageRates.at(i)<<" ";
		outputFile << featureModifiedMeanAbsoluteValue1s.at(i)<<" ";
		//outputFile << (bicepsSize[i]*bicepsSize[i])/(weights[i]/((heights[i]/100)*(heights[i]/100))) <<" ";
		if((i>=40&&i<130)||i>=160){
			if(i<50||(i>=70&&i<=89)||(i>169&&i<195)){ //Tu?berk
				outputFile << (bicepsSize[13]*bicepsSize[13])/(weights[13]/((heights[13]/100)*(heights[13]/100))) <<" ";
			}else if((i>=50&&i<70)||(i>194&&i<205)){//M?cahit
			    outputFile << (bicepsSize[8]*bicepsSize[8])/(weights[8]/((heights[8]/100)*(heights[8]/100))) <<" ";
		    }else if((i>=90&&i<115)||(i>204)){//Faruk
		    	outputFile << (bicepsSize[4]*bicepsSize[4])/(weights[4]/((heights[4]/100)*(heights[4]/100))) <<" ";
			}else{//Kaz?m
				outputFile << (bicepsSize[28]*bicepsSize[28])/(weights[28]/((heights[28]/100)*(heights[28]/100))) <<" ";
			}
		}else if(i>120){
			if(i==136||i==148||i==149||i==150){//Tu?berk
				outputFile << (bicepsSize[13]*bicepsSize[13])/(weights[13]/((heights[13]/100)*(heights[13]/100))) <<" ";
			}else if(i<134||i==159){//Kaz?m
				outputFile << (bicepsSize[28]*bicepsSize[28])/(weights[28]/((heights[28]/100)*(heights[28]/100))) <<" ";
			}else if(i<140){
				outputFile << 58.1660 <<" ";
			}else if(i<144){
				outputFile << 55.5307 <<" ";
			}else if(i<148){
				outputFile << 47.8641 <<" ";
			}else if(i==151){
				outputFile << 31.1760 <<" ";
			}else if(i<154){
				outputFile << 52.8280 <<" ";
			}else if(i==154){
				outputFile << 31.3632 <<" ";
			}else if(i<159){
				outputFile << 41.1880 <<" ";
			}
		}else{
			outputFile << (bicepsSize[i]*bicepsSize[i])/(weights[i]/((heights[i]/100)*(heights[i]/100))) <<" ";
		}
		//outputFile << genders[i] << " ";
		if((i>=40&&i<130)||i>=160){
			outputFile << genders[4] << " ";
		}else if(i>120){
			if(i==151||i==154){
				outputFile << genders[0] << " ";
			}else{
				outputFile << genders[4] << " ";
			}
		}else{
			outputFile << genders[i] << " ";
		}
		if(i==dataSignals.size()-1){
			//outputFile << usedWeights[i];
			outputFile << usedWeights[6];
		}else{
			//outputFile << usedWeights[i] <<"\n";
			if((i>=40&&i<130)||i>=160){
			if(i<50||(i>=70&&i<=89)||(i>169&&i<195)){ //Tu?berk
				if(i<45){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<50){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<75){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<80){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<85){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<90){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<175){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<180){
					outputFile << usedWeights[6] <<"\n";
				}else if(i<185){
					outputFile << usedWeights[7] <<"\n";
				}else if(i<190){
					outputFile << usedWeights[6] <<"\n";
				}else{
					outputFile << usedWeights[7] <<"\n";
				}
			}else if((i>=50&&i<70)||(i>194&&i<205)){//M?cahit
			    if(i<55){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<60){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<65){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<70){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<200){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[6] <<"\n";
				}
		    }else if((i>=90&&i<115)||(i>204)){//Faruk
		    	if(i<95){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<100){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<105){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<110){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<115){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<210){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[6] <<"\n";
				}
			}else{//Kaz?m
				if(i<120){
					outputFile << usedWeights[1] <<"\n";
				}else if(i<125){
					outputFile << usedWeights[2] <<"\n";
				}else if(i<130){
					outputFile << usedWeights[5] <<"\n";
				}else if(i<165){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[6] <<"\n";
				}
			}
		}else if(i>120){
			if(i==136||i==148||i==149||i==150){//Tu?berk
				if(i==136||i==150){
					outputFile << usedWeights[7] <<"\n";
				}else if(i==148){
					outputFile << usedWeights[2] <<"\n";
				}else{
					outputFile << usedWeights[5] <<"\n";
				}
			}else if(i<134||i==159){//Kaz?m
				if(i<134){
					outputFile << usedWeights[1] <<"\n";
				}else{
					outputFile << usedWeights[5] <<"\n";
				}
			}else if(i<140){
				if(i==137){
					outputFile << usedWeights[7] <<"\n";
				}else if(i==138){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[2] <<"\n";
				}
			}else if(i<144){
				if(i==140){
					outputFile << usedWeights[1] <<"\n";
				}else if(i==141){
					outputFile << usedWeights[2] <<"\n";
				}else if(i==142){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[7] <<"\n";
				}
			}else if(i<148){
				if(i==144){
					outputFile << usedWeights[1] <<"\n";
				}else if(i==145){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[7] <<"\n";
				}
			}else if(i==151){
				outputFile << usedWeights[2] <<"\n";
			}else if(i<154){
				if(i==152){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[7] <<"\n";
				}
			}else if(i==154){
				outputFile << usedWeights[2] <<"\n";
			}else if(i<159){
				if(i==155){
					outputFile << usedWeights[1] <<"\n";
				}else if(i==156){
					outputFile << usedWeights[2] <<"\n";
				}else if(i==157){
					outputFile << usedWeights[5] <<"\n";
				}else{
					outputFile << usedWeights[7] <<"\n";
				}
			}
		}else{
			outputFile << usedWeights[i] << "\n";
		}
		}
	}
	
	
	outputFile.close();
	
}











