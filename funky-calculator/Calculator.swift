
public class Calculator{
    public enum Operation: String{
        case Sum = "+"
        case Substraction = "-"
        case Multiplication = "*"
        case Divisition = "/"
        case Percentage = "%"
        case Empty = ""
    }
    
    public enum Errors: ErrorType{
        case DivisionBy0
        case PercentageOutOfRange
    }
    
    private var _result: Double?
    private var _operation: Operation
    
    public var currentValue: Double{
        set{
            _result = newValue
        }
        get{
            if _result == nil{
                return 0.0
            }
            else{
                return _result!
            }
        }
    }
    public var operation: Operation{
        set{
            _operation = newValue
        }
        get{
            return _operation
        }
    }
    
    public init(){
        self._result = nil
        self._operation = .Empty
    }
    
    public func perfomOperation(rigthValue: Double) throws -> Double{
        if _result == nil || _operation == Operation.Empty{
            _result = rigthValue
        }
        else{
            switch _operation {
            case .Sum:
                return add(rigthValue)
            case .Substraction:
                return subtract(rigthValue)
            case .Multiplication:
                return multiply(rigthValue)
            case .Divisition:
                if let divisitionResult = divide(rigthValue){
                    return divisitionResult
                }else{
                    throw Errors.DivisionBy0
                }
            case .Percentage:
                if let percentageResult = percentage(rigthValue){
                    return percentageResult
                }else{
                    throw Errors.PercentageOutOfRange
                }
            default:
                break
            }
        }
        return _result!
    }
    
    private func add(rigthValue: Double) -> Double{
        _result! += rigthValue
        return _result!
    }
    
    private func subtract(rightValue: Double) -> Double{
        _result! -= rightValue
        return _result!
    }
    
    private func multiply(rigthValue: Double) -> Double{
        _result! *= rigthValue
        return _result!
    }
    
    private func percentage(rigthValue: Double) -> Double?{
        if rigthValue < 0.0 || rigthValue > 100.0{
            clear()
            return nil
        }
        let percentage = rigthValue * 0.01;
        _result! *= percentage
        return _result
    }
    
    private func divide(rigthValue: Double) -> Double?{
        if rigthValue == 0{
            clear()
            return nil
        }
        _result! /= rigthValue
        return _result
    }
    
    public func clear(){
        _result = nil
        _operation = Operation.Empty
    }
}
