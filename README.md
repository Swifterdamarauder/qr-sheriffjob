# qr-sheriffjob
This is a conversion of QR-Policejob


# Install
1. Add this to the folder named `[framework]` or whatever folder contains all of your qrcore resources
2. Go to `qr-core` folder then the `shared` folder
3. Open `jobs.lua`
4. 3. Add sheriff job use example below;

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

5. restart your server!
