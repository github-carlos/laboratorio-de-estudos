package application

type ProductService struct {
	Persistence ProductPersistenceInterface
}

func (ps *ProductService) Get(id string) (ProductInterface, error) {
	product, err := ps.Persistence.Get(id)

	if err != nil {
		return nil, err
	}

	return product, nil
}