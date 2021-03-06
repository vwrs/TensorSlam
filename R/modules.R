#' Other Modules

#' @param C WIP
#' @param old_ind WIP
#' @name WIP
NULL

#' @rdname WIP
inew <- function(C,old_ind){
	n <- dim(C)[1]
	vec <- rep(0,n)
	for(i in 1:n){
		vec[i] <- sqrt(sum((C[i,]$v)^2))
	}
	ind <- order(abs(vec),decreasing=T)
	if(!any(old_ind==ind[1])){
		ind <- ind[1]
	}else if(!any(old_ind==ind[2])){
		ind <- ind[2]
	}else if(!any(old_ind==ind[3])){
		ind <- ind[3]
	}else if(!any(old_ind==ind[4])){
		ind <- ind[4]
	}else if(!any(old_ind==ind[5])){
		ind <- ind[5]
	}else if(!any(old_ind==ind[6])){
		ind <- ind[6]
	}else if(!any(old_ind==ind[7])){
		ind <- ind[7]
	}else if(!any(old_ind==ind[8])){
		ind <- ind[8]
	}else if(!any(old_ind==ind[9])){
		ind <- ind[9]
	}else if(!any(old_ind==ind[10])){
		ind <- ind[10]
	}else if(!any(old_ind==ind[11])){
		ind <- ind[11]
	}else if(!any(old_ind==ind[12])){
		ind <- ind[12]
	}else if(!any(old_ind==ind[13])){
		ind <- ind[13]
	}else if(!any(old_ind==ind[14])){
		ind <- ind[14]
	}else if(!any(old_ind==ind[15])){
		ind <- ind[15]
	}else if(!any(old_ind==ind[16])){
		ind <- ind[16]
	}else if(!any(old_ind==ind[17])){
		ind <- ind[17]
	}else if(!any(old_ind==ind[18])){
		ind <- ind[18]
	}else{
		ind <- ind[19]
	}
	return(ind)
}


#' @rdname WIP
#' @param Y WIP
#' @param k WIP
#' @param eps WIP
FSTD <- function(Y,k,eps=NULL){
	I <- dim(Y)
	N <- length(I)

	index <- lapply(1:N,function(n){
				ceiling(runif(1,min=0,max=1)*I[n])
})
	ssub <- rep(1,N)

	p <- 2
	completed <- rep(0,N)

	while(p<=k && (prod(completed)==0)){
		#                 browser()
		#                 print(paste0('p=',p))
		for(n in 1:N){
			if(completed[n]==0){
				if(p==2 && n==1){
					index[[n]] <- c(index[[n]],ceiling(runif(1,min=0,max=1)*I[n]))
					ssub[n] <- ssub[n]+1
				}else{
					YresNorm <- sqrt(sum((Yres$v)^2))
					FIBredNorm <- sqrt(sum((FIBred[[nextInd]]$v)^2))
					if((YresNorm/FIBredNorm)>eps){ #WIP
						index[[n]] <- c(index[[n]],inew(Yres,index[[n]]))
						ssub[n] <- ssub[n]+1
						#                                                 print(paste0('ranks=',ssub))

					}else{
						#                                                 completed[n] <- 1
					}
				}

				W <- Y[index[[1]],index[[2]],index[[3]]]
				Wpinv <- list()
				FIB <- list()
				for(m in 1:N){
					Wpinv[[m]] <- ginv(as.simple_triplet_matrix(kModeUnfold(tnsr = W,m=m)))
					ind <- index
					ind[[m]] <- 1:I[m]
					FIB[[m]] <- as.simple_triplet_matrix(kModeUnfold(Y[ind[[1]],ind[[2]],ind[[3]]],m))
				}
				#                                 print('FIB')
				#                                 print(FIB)
				U <- reconstTucker(core = W,Wlist = Wpinv)
			}
			if(n==N){
				nextInd <- 1
			}else{
				nextInd <- n+1
			}

			if(completed[nextInd]==0){
				FIBred <- list() 
				for(m in 1:N){
					FIBred[[m]] <- FIB[[m]][index[[m]],]
				}
				#                                 print('FIBred')
				#                                 print(FIBred)
				ind <- index
				ind[[nextInd]] <- 1:I[nextInd]
				FIBred[[nextInd]] <- FIB[[nextInd]]
				smat <- ssub
				smat[nextInd] <- I[nextInd]

				mother <- Y[ind[[1]],ind[[2]],ind[[3]]]
				child <- reconstTucker(core = U,Wlist = FIBred)
				#diff
				mother <- as.array(mother)
				child <- as.array(child)
				tnsrDiff <- as.simple_sparse_array(mother-child)
				Yres <- kModeUnfold(tnsrDiff,nextInd)
			}
		}
		p <- p+1
	}
	#         browser()

	res <- list(g=U,As=FIB)

	return(res)
}



#' @rdname WIP
#' @param arrName WIP
#' @param ind WIP

extractArrayExpr <- function(arrName,ind){
	#多次元配列の次元が様々でも，配列名とインデックスを与えるだけでその場所を取り出してくるための文字列を返す
	#hoge[,,,] hoge[,,] hoge[,] と書き分けるのが面倒な時に
	stopifnot(class(arrName)=='character')

	header <- paste0(arrName,'[')
	footer <- ']'

	content <- sapply(1:length(ind),function(i){
				  content <- paste0('c(',toString(ind[[i]]),')')
})
	content <- toString(content)
	res <- paste0(header,content,footer) 
	#eval(parse(text=res)) #この場で評価はしない
	return(res)
}
	


