class PlantVariables {
  float light;
  float temp;
  float water;

  float bloomFactor;
  float growFactor;
  float branchFactor; 

  PlantVariables(float light, float temp, float water) {
    this.light = light;
    this.temp = temp;
    this.water = water;

    normalizeFactors();
    calculateFactors();
  }

  void normalizeFactors() {
    this.light = constrain(this.light, 1, 10);
    this.temp = constrain(this.temp, 1, 10);
    this.water = constrain(this.water, 1, 10);
  }

  void calculateFactors() {
    float tempModifier = this.temp / 10.0;
    
    this.growFactor = this.light * tempModifier;
    this.branchFactor = this.water * tempModifier;
    this.bloomFactor = (this.water + this.light) / 2.0 * tempModifier;
  }
}
