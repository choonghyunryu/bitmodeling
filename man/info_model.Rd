% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predefined_model.R
\name{info_model}
\alias{info_model}
\title{Statistics for Model Performance}
\usage{
info_model(x, stats = c("coef", "cmat", "metrics", "quantiles"), nbins = 10)
}
\arguments{
\item{x}{workflow. get_training() 결과로 생성한 모델, workflow 객체.}

\item{stats}{character. 계산할 성능 평가 정보. 
c("coef", "cmat", "metrics", "quantiles")에서 선택.}

\item{nbins}{integer. 예측 확률을 비닝할 때 사용할 빈(Bins)의 개수. 
stats의 값이 "quantiles"일 경우만 적용되며 기본값은 10.}
}
\value{
tbl_df, conf_mat 클래스의 객체. stats의 종류에 따라 반환하는 객체의 유형이 다름.
}
\description{
모델링 함수로 생성한 모델에 대해서 성능 평가를 위한 통계를 계산함
}
\details{
stats의 값이 "coef"일 경우에는 regression 기반의 모델은 terms 계수를 tbl_df 객체로 반환하고, 
tree 기반의 모델은 variable importance scores를 반환함.
regression 기반의 모델,
\itemize{
\item term factor. 모델을 정의한 terms. 
\item estimate numeric. 모델을 정의한 terms의 추정 계수. 
\item penalty numeric. 모델에 사용한 penalty. 
\item `estimate > 0` logical. 추정 계수가 0보다 큰가의 여부.
}
tree 기반의 모델,
\itemize{
\item term factor. 모델을 정의한 terms. 
\item Importance numeric. importance scores. 
\item Importance_scal numeric. 최대값 기준으로 스케일된 importance scores. 
}

stats의 값이 "cmat"일 경우에는 Confusion Matrix를 conf_mat 클래스 객체로 반환함.

stats의 값이 "metrics"일 경우에는 성능 평가 지표를 tbl_df 클래스 객체로 반환함.
\itemize{
\item .metric character. 성능 평가지표 이름. 
\item .estimator character. taget 변수의 데이터 유형. 
\item .estimate numeric. 성능 평가지표 값. 
}

stats의 값이 "quantiles"일 경우에는 예측 확률의 구간별 분포 정보를 tbl_df 클래스 객체로 반환함.
\itemize{
\item binn character. 예측 확률을 비닝한 구간. 
\item n integer. 데이터 건수. 
\item positive integer. 구간에서의 positive 데이터 건수. 
\item negative integer. 구간에서의 negative 데이터 건수. 
\item prob_positive numeric. 구간에서의 positive 비율. 
\item lift numeric. 구간에서의 positive 비율에 대한 lift. 
}
}
\examples{
\donttest{
# 모델 개발을 위한 recipe 정의
data_recipe <- dlookr::heartfailure \%>\% 
  target_to(death_event) \%>\% 
  set_positive("Yes") \%>\% 
  split_dataset(prop = 0.7) \%>\% 
  extract_dataset() \%>\% 
  set_formula() \%>\% 
  step_my_center() \%>\% 
  step_my_dummy() \%>\% 
  step_my_rose()

# 정의한 recipe로 모델 빌드
my_model <- get_training(data_recipe)

# 모델 terms의 계수 계산
info_model(my_model, "coef")

# 모델의 Confusion Matrix 계산
info_model(my_model, "cmat") 

# 모델의 성능 평가지표 계산
info_model(my_model, "metrics")

# 예측 확률의 구간별 분포 계산
info_model(my_model, "quantiles") 

# 예측 확률의 구간별 분포 계산, bins의 개수를 15개로 계산
info_model(my_model, "quantiles", nbins = 15) 
}

}
\seealso{
\code{\link{viz_model}}
}
