# fitness_advisor.jac
"""
Personalized Fitness Advisor using AI guidance
"""

import from byllm.llm { Model }

glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

def give_fitness_response(user_data: dict) -> str by llm();

obj FitnessAssessment {
    has user_data: dict;

    # Abstract method
    def collectData {
        raise NotImplementedError("Subclasses must implement this method.");
    }
}

obj GetFitnessPlan (FitnessAssessment) {
    has user_data: dict;

    # Initialize storage
    def init {
        self.user_data = {};
    }

    # Collect user metrics and preferences
    override def collectData {
    
        print("WELCOME TO PERSONAL FITNESS ADVISOR. ENTER YOUR DETAILS.");
        
        data:dict = {};
        data["age"] = int(input("Enter your age: "));
        data["height_cm"] = float(input("Enter your height in cm: "));
        data["weight_kg"] = float(input("Enter your weight in kg: "));
        data["gender"] = input("Enter your gender (M/F/Other): ");
        data["activity_level"] = input("Your current activity level (sedentary, moderate, active): ");

        print("\n=======================================");
        print("LET'S UNDERSTAND YOUR FITNESS GOALS.");
        print("=======================================");

        goals:dict = {};
        goals["goal_weight_loss"] = input("Do you want to lose weight? (yes/no): ");
        goals["goal_muscle_gain"] = input("Do you want to gain muscle? (yes/no): ");
        goals["goal_endurance"] = input("Do you want to improve endurance? (yes/no): ");
        goals["goal_flexibility"] = input("Do you want to improve flexibility? (yes/no): ");
        goals["preferred_workouts"] = input("Do you prefer gym, home workouts, or outdoor activities?: ");

        data["goals"] = goals;

        self.user_data = data;

        # Step 3: Send to AI
        self.process_data(self.user_data);
    }

    # Process data using LLM
    def process_data(user_data: dict) {
        print("\nAnalyzing your data and generating a personalized fitness plan...");
        response = give_fitness_response(user_data);
        print("\n💪 YOUR FITNESS ADVICE:\n" + response);
    }
}

with entry {
    fitness = GetFitnessPlan();
    fitness.collectData();
}
