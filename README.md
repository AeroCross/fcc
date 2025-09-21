# Term Deposit Calculator

A simple term deposit calculator that mimics [Bendigo Bank's deposit and savings calculator](https://www.bendigobank.com.au/calculators/deposit-and-savings/).

## Requirements

- Ruby 3.4.6 (earlier versions will work, but they haven't been tested)

## Installation

I use [mise](https://mise.jdx.dev/), but any version manager will work. The installation instructions provided assume you're also using mise.

However, I have provided both `rbenv` and `asdf` idiomatic version files (e.g `.ruby-version`, `.tool-versions`) so they're automatically recognised.

1. Clone this repository (e.g `git@github.com:AeroCross/fcc.git`)
1. Enter the repository (`cd fcc`)
1. Install and use Ruby (`mise use ruby@3.4.6`)
1. Run `bundle install`
1. Run `ruby main.rb --help` to get started.

```
Usage: main [options]
    -a, --amount INT                 Amount to deposit (e.g 15600)
    -t, --term INT                   How long the term deposit is in months (e.g 36)
    -r, --rate FLOAT                 Interest rate per annum (e.g 1.2)
    -c, --cadence STR                How often is interest paid
```

## Running tests

After running `bundle install`, you should have access to `rspec`.

To run all tests:

```
$ rspec .

[...]

Finished in 0.03141 seconds (files took 0.10378 seconds to load)
36 examples, 0 failures

Randomized with seed 64785
```

### Design decisions, thoughts and assumptions

#### Floating-point arithmetic

The most important thing to remember about this code is that my intention was never to provide decimal-perfect
calculations, but to accurately replicate the Bendigo Calculator's output. This is the main reason why I am using Float
arithmetic: there are _much_ better alternatives to handle this, such as using
[BigDecimal] (which used to be part of Ruby's stdlib), or using a Money gem, like [Money] or [Monetize].

[BigDecimal]: https://github.com/ruby/bigdecimal
[Money]: https://github.com/RubyMoney/money
[Monetize]: https://github.com/RubyMoney/monetize

#### Reference values

All the specs use reference values from the Calculator, and from the Coding Exercise. Under the "reference scenarios",
I'm using the actual values provided by the document as a first step, then I go into the calculator, put in random
combinations, and put them back into the specs.

This way, I can be confident that the output is faithful to the calculator regardless of the values, and they're **not**
copied across specs. This should help ensure that even if the reference values are very close / the same
(due to rounding), the specs can still confidently communicate that the formulas are working.

#### Separation of Concerns and Code Quality

`main.rb` is very crude. It's meant to be the most barebones, straightforward way of providing a CLI that outputs what
the acceptance criteria of this exercise is, without wasting almost an time. However, the program has been designed
that the underlying calculator and output code can be plugged into anything.

You can consider `main.rb` and `money_formatter.rb` utilitarian and practical, and the `Calculator` namespace what
I'd be using for providing a UI, or creating a gem.

#### Gem (library) usage

It was very intentional to use just the Ruby stdlib. `standard` is there to reduce as much bikeshedding as possible, and
`rspec` is there as a testing framework (any would be fine, it's personal preference at this stage).

I personally believe that using any other gem would distract from the purpose of the exercise (simple object modelling,
separation of concerns, demonstrating understanding of the underlying concepts of the business domain, etc.), even
though in a real production environment, you'd try to use tried-and-tested gems for specific scenarios, like a
Currency / Money gem, a fully-featured CLI parser, `ActiveSupport::NumberHelper` for displaying money correctly, or
something like Rails or Hanami to handle rendering into a webpage.

#### Code comments

I have sprinkled a bit of [YARDoc], which is mostly a personal preference.

I can understand that different teams have different degrees of desire about communicating via comments. My IDE already
provides this parsing, and it allows to easily generate documentation with the inclusion of a single gem. Using
something like Sorbet would probably solve this need.

[YARDoc]: https://yardoc.org/