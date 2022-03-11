#ifndef ast_unary_hpp
#define ast_unary_hpp

#include <string>
#include <iostream>

//to do: add MODULUO to operators file

class Unary
    : public Expression
{
private:
    ExpressionPtr expr;
protected:
    Unary(const ExpressionPtr _expr)
        : expr(_expr)
    {}
public:
    virtual ~Unary()
    {
        delete expr;
    }

    virtual const char *getOpcode() const =0;

    ExpressionPtr getExpr() const
    { return expr; }

    virtual void print(std::ostream &dst) const override
    {
        dst << "( ";
        dst << getOpcode();
        dst << " ";
        expr->print(dst);
        dst << " )";
    }
};


class LogNotOperator
    : public Unary
{
public:
    NegOperator(const ExpressionPtr _expr)
        : Unary(_expr)
    {}

    virtual const char *getOpcode() const override
    { return "!"; }

    virtual double evaluate(
        const std::map<std::string, double> &bindings
    ) const override
    {
    	double n=getExpr()->evaluate(bindings);
        return !n;
        throw std::runtime_error("LogNotOperator::evaluate is not implemented.");
    }
};
class BitwiseNotOperator
    : public Unary
{
public:
    BitwiseNotOperator(const ExpressionPtr _expr)
        : Unary(_expr)
    {}

    virtual const char *getOpcode() const override
    { return "~"; }

    virtual double evaluate(
        const std::map<std::string, double> &bindings
    ) const override
    {
    	double n=getExpr()->evaluate(bindings);
        return ~n;
        throw std::runtime_error("BitwiseNotOperator::evaluate is not implemented.");
    }
};

class NegOperator
    : public Unary
{
public:
    NegOperator(const ExpressionPtr _expr)
        : Unary(_expr)
    {}

    virtual const char *getOpcode() const override
    { return "-"; }

    virtual double evaluate(
        const std::map<std::string, double> &bindings
    ) const override
    {
    	double n=getExpr()->evaluate(bindings);
        return -n;
        throw std::runtime_error("NegOperator::evaluate is not implemented.");
    }
};

#endif