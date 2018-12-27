class Train{
  ArrayList<SnakeController> population;
  int popSize = 1000;
  int currentSnake;
  int currentGeneration;
  int frameCount = 0;
  int numHidden = 8;
  int numInputs = 12;
  int numOutputs = 4; 
  boolean kill = false;
  Game g;
  
  public Train(){
    population = new ArrayList<SnakeController>();
    currentGeneration = 0;
    currentSnake = 0;
    initPopulation();
    g = new Game();
  }
  
  void initPopulation(){
    for(int i = 0; i < popSize; i++){
      population.add(new SnakeController(new Network(), 0));
    }
  }
  
  void createNextGeneration(){
    // breeding pool consists of indeces of snake controllers
    double avgFitness = 0;
    for(int i = 0; i < popSize; i++){
      avgFitness += population.get(i).fitness;
    }
    avgFitness /= popSize;
    
    println("Average fitness generation " + currentGeneration + ": " + avgFitness);
    printFitnesses();
    
    
    ArrayList<Integer> breedingPool = new ArrayList<Integer>();
    ArrayList<SnakeController> newPopulation = new ArrayList<SnakeController>();
    sortPopulation();
    //printFitnesses();
    // populate the breeding pool:
    // bottom 25% --> gets 1
    // 25-50% --> 5
    // 50-75% --> 10
    // 75-100% --> 20
    for(int i = 0; i < popSize; i++){
      if(i < popSize / 4){
        breedingPool.add(i);
      } else if(i < popSize / 2){
        for(int j = 0; j < 5; j++){
          breedingPool.add(i);
        }
      } else if(i < 3 * popSize / 4){
        for(int j = 0; j < 10; j++){
          breedingPool.add(i);
        }
      } else if (i > 3 * popSize / 4 ) {
        for(int j = 0; j <  100; j++){
          breedingPool.add(i);
        }
      } 
    }
    
    // create next generation
    for(int i = 0; i < popSize/10; i++){
      newPopulation.add(population.get(population.size() - i - 1));
      //println("Snake " + i + " fitness: " + population.get(population.size() - i - 1).fitness);
      newPopulation.get(i).fitness = 0;
    }
    int n = breedingPool.size();
    for(int i = popSize/10; i < popSize; i++){
      int parentAIndex = breedingPool.get((int)random(0, n));
      int parentBIndex = breedingPool.get((int)random(0, n));
      Network newSnakeControllerNetwork = crossoverWeights(parentAIndex, parentBIndex);
      newPopulation.add(new SnakeController(newSnakeControllerNetwork, 0));
    }
    
    population = newPopulation;
    //printFitnesses();
  }
 
  Network crossoverWeights(int parentAIndex, int parentBIndex){
    Network network = new Network();
    Matrix weightsA = population.get(parentAIndex).network.weights;
    Matrix outputWeightsA = population.get(parentAIndex).network.outputWeights;
    Matrix weightsB = population.get(parentBIndex).network.weights;
    Matrix outputWeightsB = population.get(parentBIndex).network.outputWeights;

    int pivotI = (int)random(0, weightsA.getNumRows());
    int pivotJ = (int)random(0, weightsA.getNumCols());
    for(int i = 0; i < weightsA.getNumRows(); i++) {
      for(int j = 0; j < weightsA.getNumCols(); j++) {
        if(i < pivotI || (i < pivotI && j <= pivotJ)) {
          continue;
        } else {
          weightsA.set(i, j, weightsB.get(i, j));
        }
        
        
        int mutatePivot = (int)random(0, 100);
        if(mutatePivot < 1){
          weightsA.set(i, j, random(-1, 1));
        }
      }
    }    
    pivotI = (int)random(0, outputWeightsA.getNumRows());
    pivotJ = (int)random(0, outputWeightsA.getNumCols());

        
  
    for(int i = 0; i < outputWeightsA.getNumRows(); i++) {
      for(int j = 0; j < outputWeightsA.getNumCols(); j++) {
        if(i < pivotI || (i < pivotI && j <= pivotJ)){
          continue;
        } else {
          outputWeightsA.set(i, j, outputWeightsB.get(i, j));
        }
        
        int mutatePivot = (int)random(0, 100);
        if(mutatePivot < 1){
          outputWeightsA.set(i, j, random(-1, 1));
        }
      }
    };    network.setWeights(weightsA);
    network.setOutputWeights(outputWeightsA);
    
    return network;
  }
  // this is literally a bubble sort
  void sortPopulation(){
    for (int i = 0; i < popSize-1; i++) {
      for (int j = 0; j < popSize-i-1; j++) {
        if (population.get(j).fitness > population.get(j+1).fitness) { 
            // swap arr[j+1] and arr[i] 
            SnakeController temp = population.get(j); 
   
            this.population.set(j, population.get(j+1)); 
            this.population.set(j+1, temp); 
        } 
      }
    }
  }
  
  void printFitnesses(){
    for(int i = 0; i < popSize; i++){
      print(population.get(i).fitness + " ");
    }
    println();
  }
  
  void kill(){
    this.kill = true;
  }
  
  void go(){
    if(currentSnake == popSize - 1){
      currentSnake = 0;
      currentGeneration++;
      createNextGeneration();
    }
    
    if(g.getSnake().dead || kill){
      g = new Game();
      g.setDirection(-1);
      currentSnake++;
      kill = false;
    }
    
    Network currentNetwork = (Network)(population.get(currentSnake).network);
    Matrix inputs = g.getSnake().updateInputs(g.getApple());
    Data inputData = new Data(inputs, maxDist);
    inputData.cleanData();
    int direction = currentNetwork.feedforward(inputData);

    g.setDirection(direction);
    g.draw();
    population.get(currentSnake).fitness += g.getChangeInFitness();
    g.drawTrainingInfo(currentSnake + 1, currentGeneration + 1, population.get(currentSnake).fitness);
    g.checkSnakeLifespan();
  }
}
