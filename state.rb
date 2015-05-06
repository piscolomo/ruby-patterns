#This pattern try to simplify complicate control flows changing an object's behaviour dynamically
class Operation
  attr_reader :state
  def initialize
    @state = OperationOpenState.new
  end

  def trigger(state)
    @state = @state.next(state)
  end
end

class OperationOpenState
  def next(state)
    valid?(state) ? OperationPendingPaymentState.new : raise IllegalStateJumpError
  end

  def valid?(state)
    state == :pending_payment
  end
end

class OperationPendingPaymentState
  def next(state)
    OperationConfirmState.new if valid?(state)
  end

  def valid?(state)
    state == :confirm
  end
end
class IllegalStateJumpError < StandardError; end
class OperationConfirmState; end

#Usage
operation = Operation.new
puts operation.state.class
#=> OperationOpenState
operation.trigger :pending_payment
puts operation.state.class
#=> OperationPendingPaymentState
operation.trigger :confirm
puts operation.state.class
#=> OperationConfirmState

operation = Operation.new
operation.trigger :confirm
#=> raise IllegalStateJumpError