<?php
require_once __DIR__ . '/../vendor/autoload.php';

use Phpml\Dataset\CsvDataset;
use Phpml\Dataset\ArrayDataset;
use Phpml\FeatureExtraction\TokenCountVectorizer;
use Phpml\ModelManager;
use Phpml\Tokenization\WordTokenizer;
use Phpml\CrossValidation\StratifiedRandomSplit;
use Phpml\FeatureExtraction\TfIdfTransformer;
use Phpml\Metric\Accuracy;
use Phpml\Classification\SVC;
use Phpml\SupportVectorMachine\Kernel;

$dataset = new CsvDataset('languages.csv', 1);
$samples = [];
foreach ($dataset->getSamples() as $sample) {
    $samples[] = $sample[0];
}

$vectorizer = new TokenCountVectorizer(new WordTokenizer());

$tfIdfTransformer = new TfIdfTransformer();

$vectorizer->fit($samples);
$vectorizer->transform($samples);

$tfIdfTransformer->fit($samples);
$tfIdfTransformer->transform($samples);

$s = serialize($vectorizer);
file_put_contents('vectorizer', $s);

$s = serialize($tfIdfTransformer);
file_put_contents('tfIdfTransformer', $s);

$dataset = new ArrayDataset($samples, $dataset->getTargets());

$randomSplit = new StratifiedRandomSplit($dataset, 0.3);

$classifier = new SVC(Kernel::SIGMOID, 10000);

$classifier->train($randomSplit->getTrainSamples(), $randomSplit->getTrainLabels());

$filepath = 'svc.ini';
$modelManager = new ModelManager();
$modelManager->saveToFile($classifier, $filepath);

$predictedLabels = $classifier->predict($randomSplit->getTestSamples());
echo 'Accuracy: '.Accuracy::score($randomSplit->getTestLabels(), $predictedLabels);