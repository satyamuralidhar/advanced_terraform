users = {
    "user1" = {
        name = "user01"
    }
    "user2" = {
        name = "user02"
    }
    "user3" = {
        name = "user03"
    }
}

rsgs = [ 
    {
    suffix = "training"
    location = "eastus"
    storage = true
    bastion = true
    },
    {
    suffix = "utility"
    location = "southcentralus"
    storage = false
    bastion = false
    }

 ]