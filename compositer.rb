# Composition over inheritance. Compose objects intro tree structures to represent part-whole hierarchies
class CompositeQuest
  def initialize
    @tasks = []
  end

  def <<(task)
    @tasks << task
  end

  def reward
    @tasks.inject(0){ |sum, task| sum += task.reward }
  end
end

class MegaQuest < CompositeQuest
end

class Quest < CompositeQuest
end

class MonsterTask
  attr_reader :reward

  def initialize
    @reward = 100
  end
end

class PuzzleTask
  attr_reader :reward

  def initialize
    @reward = 200
  end
end

# Usage
quest1 = Quest.new
quest1 << MonsterTask
quest1 << PuzzleTask
puts quest1.reward
# => 300

quest2 = Quest.new
quest2 << MonsterTask
quest2 << PuzzleTask
megaquest = MegaQuest.new
megaquest << quest1
megaquest << quest2
puts megaquest.reward
# => 600