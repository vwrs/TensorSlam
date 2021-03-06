context('MUNTD')

test_that('3d HOSVD-MUNTD',{
		  tnsr <- as.simple_sparse_array(array(1:216,dim=c(6,6,6)))
		  res <- MUNTD(tnsr,core_dims=c(2,2,2),lra_ranks=c(4,4,4),method='HOSVD')

		  expect_equal(dim(res$g),c(2,2,2)) 
		  expect_equal(dim(res$As[[1]]),c(6,2)) 
		  expect_equal(dim(res$As[[2]]),c(6,2)) 
		  expect_equal(dim(res$As[[3]]),c(6,2)) 

		  expect_equal(class(res$g),'array') 
		  expect_equal(class(res$As[[1]]),'matrix') 
		  expect_equal(class(res$As[[2]]),'matrix') 
		  expect_equal(class(res$As[[3]]),'matrix') 
})

test_that('4d HOSVD-MUNTD',{
		  tnsr <- as.simple_sparse_array(array(1:6^4,dim=c(6,6,6,6)))
		  res <- MUNTD(tnsr,core_dims=c(2,2,2,2),lra_ranks=c(4,4,4,4),method='HOSVD')

		  expect_equal(dim(res$g),c(2,2,2,2)) 
		  expect_equal(dim(res$As[[1]]),c(6,2)) 
		  expect_equal(dim(res$As[[2]]),c(6,2)) 
		  expect_equal(dim(res$As[[3]]),c(6,2)) 
		  expect_equal(dim(res$As[[4]]),c(6,2)) 

		  expect_equal(class(res$g),'array') 
		  expect_equal(class(res$As[[1]]),'matrix') 
		  expect_equal(class(res$As[[2]]),'matrix') 
		  expect_equal(class(res$As[[3]]),'matrix') 
		  expect_equal(class(res$As[[4]]),'matrix') 
})

test_that('3d FSTD-MUNTD',{
		  tnsr <- as.simple_sparse_array(array(1:1000,dim=c(10,10,10)))
		  res <- MUNTD(tnsr,core_dims=c(2,2,2),lra_ranks=c(3),method='FSTD')

		  expect_equal(dim(res$g),c(2,2,2)) 
		  expect_equal(dim(res$As[[1]]),c(10,2)) 
		  expect_equal(dim(res$As[[2]]),c(10,2)) 
		  expect_equal(dim(res$As[[3]]),c(10,2)) 

		  expect_equal(class(res$g),'array') 
		  expect_equal(class(res$As[[1]]),'matrix') 
		  expect_equal(class(res$As[[2]]),'matrix') 
		  expect_equal(class(res$As[[3]]),'matrix') 
})

test_that('4d FSTD-MUNTD',{
		  tnsr <- as.simple_sparse_array(array(1:10000,dim=c(10,10,10,10)))
		  res <- MUNTD(tnsr,core_dims=c(2,2,2,2),lra_ranks=c(3),method='FSTD')

		  expect_equal(dim(res$g),c(2,2,2,2)) 
		  expect_equal(dim(res$As[[1]]),c(10,2)) 
		  expect_equal(dim(res$As[[2]]),c(10,2)) 
		  expect_equal(dim(res$As[[3]]),c(10,2)) 
		  expect_equal(dim(res$As[[4]]),c(10,2)) 

		  expect_equal(class(res$g),'array') 
		  expect_equal(class(res$As[[1]]),'matrix') 
		  expect_equal(class(res$As[[2]]),'matrix') 
		  expect_equal(class(res$As[[3]]),'matrix') 
		  expect_equal(class(res$As[[4]]),'matrix') 
})
