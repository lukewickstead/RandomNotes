
```
DateTime convertedDate = DateTime.Parse(dateStr);

var kind = convertedDate.Kind; // will equal DateTimeKind.Unspecified

```

You say you know what kind it is, so tell it.

```
DateTime convertedDate = DateTime.SpecifyKind(
    DateTime.Parse(dateStr),
    DateTimeKind.Utc);

var kind = convertedDate.Kind; // will equal DateTimeKind.Utc
```

Now, once the system knows its in UTC time, you can just call ToLocalTime:

```
DateTime dt = convertedDate.ToLocalTime();
```