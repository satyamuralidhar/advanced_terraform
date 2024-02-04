locals {
    setproduct  = setproduct(["dev","qe","prod"] , [ "apptier", "dbtier" ,"catalog"] )
    setsubtract = setsubtract(["dev","qe","test","prod"], ["dev","qe","prod"])
    setunion = setunion(["dev","qe","test","prod"], ["dev","qe","prod"])

    #setintersection(["a", "b"], ["b", "c"], ["b", "d"]) ==> ["b",]
    setintersection = setintersection(["dev","app"],["test","app"],["prod","app"])
    
    #slice => (list , startindex , endindex)
    slice = slice(["app","db","web"], 1, 2) 
    sort = sort(["dev","qe","test","prod"])
    sum = sum([10,68,0.5,11])
    transpose = transpose({"murali" = ["devOps","Azure"] , "satya" = ["SRE","AWS"]})
    values = values({"dev" = "dev-rg-01" , "prod" = "prod-rg-01"})
    zipmap = zipmap(["app","db"],["appvm01","dbvm01"])
    chunklist = chunklist(["app","dev","qe","sre","prod"],2)
    alltrue01 = alltrue([true,true]) 
    alltrue02 = alltrue([true,false])
    anytrue01 = anytrue([true,true]) 
    anytrue02 = anytrue([true,false])


    #contains whch will take only contained values form the list 
    contains = contains(["dev","test","prod"],"test")

    #compact will avoid the null and empty values form the list
    compact = compact(["a","b","","c",null,"d"])
    
    # concat will merging two lists into one list not igonred null vaules
    concat = concat(["a","b","","c"],["d","e",null,"f"])
   
   # it can convert nested list into single list and avoid empty list
    flatten = flatten([["dev","qe"],[["prod","test"]],[]])

    # element can give the value form the list given index number < indexing starts form 0 , 1 , 2, 3, 4>
    element = element(["dev","test","prod"],2)
    
    #index will give index number of the value form the list
    index = index(["dev","test","prod"],"prod")
    
    #distinct can avoid duplicate values from the list
    distinct = distinct(["app","dev","qe","app","prod","app"])
    
    # will avoid empty values and give starting values after empty values
    coalesce = coalesce("","dev","test")

    # will avoid empty lists and give starting values after empty lists note: --> [""] this value also not empty list
    coalescelist = coalescelist([],[""],["dev","test"])
   
   # range will give the 0 to 5 number or 0 , 0.5 , 1 , 1.5
    range01 = range(0,5)
    range02 = range(0,5,0.5)
}

output "setproduct" {
  value = local.setproduct
}

output "setsubtract" {
  value = local.setsubtract
}

output "setunion" {
  value = local.setunion
}

output "setintersection" {
  value = local.setintersection
}

output "slice" {
  value = local.slice
}

output "sort" {
  value = local.sort
}

output "sum" {
    value = local.sum
}

output "transpose" {
  value = local.transpose
}

output "values" {
  value = local.values
}

output "zipmap" {
  value = local.zipmap
}

output "chunklist" {
  value = local.chunklist
}

output "alltrue01" {
  value = local.alltrue01
}
output "alltrue02" {
  value = local.alltrue02
}
output "anytrue01" {
  value = local.anytrue01
}
output "anytrue02" {
  value = local.anytrue02
}

output "contains" {
  value = local.contains
}

output "compact" {
  value = local.compact
}

output "concat" {
  value = local.concat
}

output "flatten" {
  value = local.flatten
}

output "element" {
  value = local.element
}

output "index" {
  value = local.index
}

output "distinct" {
  value = local.distinct
}

output "coalesce" {
    value = local.coalesce
}

output "coalescelist" {
    value = local.coalescelist
}

output "range01" {
    value = local.range01
} 

output "range02" {
    value = local.range02
} 

