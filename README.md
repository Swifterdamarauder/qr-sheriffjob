# QR-Sheriff Job
This is a conversion of QR-Policejob

# To Install
1. Add `qr-sheriffjob` to your `[framework]` folder or whatever folder contains all of your QR resources
2. Open `qr-core` folder then open the `shared` folder
3. Edit `jobs.lua` and add the following code below

```
['sheriff'] = {
    label = 'New Charleston Sheriffs Department',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Deputy',
            payment = 5
        },
        ['1'] = {
            name = 'Deputy Sheriff',
            payment = 30
        },
        ['2'] = {
            name = 'Undersheriff',
            isboss = true,
            payment = 50
        },
        ['3'] = {
            name = 'Sheriff',
            isboss = true,
            payment = 100
        },
    },
},
```

5. Save the edited `jobs.lua` 
6. Restart your server!
