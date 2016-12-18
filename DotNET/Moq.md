#Moq#


## Install ##
```
Install-Package Moq -version 4.1.1309.1617 -projectname EssentialTools.Tests
```

##Creating a Mock Object##

```
var mock = new Mock<IDiscountHelper>(); ```
```

## Stubbing ##
```
mock.Setup (m => m.ApplyDiscount(It.IsAny<decimal>())).Returns<decimal>(total => total); 
```

##It Class##
|Method |Description |
|--|--|
|Is<T>(predicate)| Specifies values of type T for which the predicate will return true. |
|IsAny<T>() |Specifies any value of the type T. 
|IsInRange<T>(min, max, kind) |Matches if the parameter is between the defined values and of type T. The final parameter is a value from the Range enumeration and can be either Inclusive or Exclusive.| 
|IsRegex(expr)|Matches a string parameter if it matches the specified regular expression.|

##Mocking For Specific Values (and Throwing an Exception)##

```
mock.Setup(m => m.ApplyDiscount(It.Is<decimal>(v => v == 0)))
    .Throws<System.ArgumentOutOfRangeException>(); 
```

```
mock.Setup(m => m.ApplyDiscount(It.Is<decimal>(v => v > 100)))
     .Returns<decimal>(total => (total * 0.9M)); 
```

##Mocking For a Range of Values##

```
mock.Setup(m => m.ApplyDiscount(
    It.IsInRange<decimal>(10, 100,Range.Inclusive)))
        .Returns<decimal>(total => total - 5);
```

```
mock.Setup(m => m.ApplyDiscount(
    It.Is<decimal>(v => v >= 10 && v <= 100)))
        .Returns<decimal>(total => total - 5);
```

##QuickStart##

http://code.google.com/p/moq/wiki/QuickStart
